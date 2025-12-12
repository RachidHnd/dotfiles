# Save clipboard image to WSL, auto-paste the path, then restore image
# This script is meant to be triggered by a hotkey (e.g., Ctrl+Shift+V)
# It saves the image, types the path automatically, then restores the image
param(
    [string]$SaveDirectory = "~/.screenshots",
    [string]$WslDistro = "auto"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Convert the tilde path to WSL format
if ($SaveDirectory -eq "~/.screenshots") {
    # Try to auto-detect WSL distribution if auto mode is used
    if ($WslDistro -eq "auto") {
        $WslDistros = @(wsl.exe -l -q | Where-Object { 
            $_ -and $_.Trim() -ne "" -and $_ -notlike "*docker*" 
        } | ForEach-Object { 
            $_.Trim() -replace '\s+', '' -replace '\x00', ''
        })
        if ($WslDistros.Count -gt 0) {
            $WslDistro = $WslDistros[0]
        }
    }
    
    # Get the actual WSL username
    $WslUsername = wsl.exe -d $WslDistro -e whoami
    $WslUsername = $WslUsername.Trim()
    $SaveDirectory = "\\wsl.localhost\$WslDistro\home\$WslUsername\.screenshots"
}

if (!(Test-Path $SaveDirectory)) {
    New-Item -ItemType Directory -Path $SaveDirectory -Force | Out-Null
}

# Load assembly for sending keystrokes
Add-Type -AssemblyName System.Windows.Forms


# Check if clipboard contains an image
if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
    # Get and backup the original image
    $originalImage = [System.Windows.Forms.Clipboard]::GetImage()
    
    if ($originalImage) {
        # Generate filename
        $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
        $filename = "screenshot_$timestamp.png"
        $filepath = Join-Path $SaveDirectory $filename
        
        # Save the image
        $originalImage.Save($filepath, [System.Drawing.Imaging.ImageFormat]::Png)
        
        # Update latest.png
        $latestPath = Join-Path $SaveDirectory "latest.png"
        if (Test-Path $latestPath) { Remove-Item $latestPath -Force }
        Copy-Item $filepath $latestPath -Force
        
        # Create WSL path
        $wslPath = "/home/$WslUsername/.screenshots/$filename"
        
        # Type the path directly character by character (more reliable than Ctrl+V)
        Start-Sleep -Milliseconds 200
        
        # Escape special characters for SendKeys
        $escapedPath = $wslPath -replace '[+^%~(){}\[\]]', '{$0}'
        [System.Windows.Forms.SendKeys]::SendWait($escapedPath)
        
        # Wait for typing to complete
        Start-Sleep -Milliseconds 300
        
        # Restore the original image back to clipboard
        [System.Windows.Forms.Clipboard]::Clear()
        Start-Sleep -Milliseconds 50
        [System.Windows.Forms.Clipboard]::SetImage($originalImage)
        
        Write-Host "Image saved: $filename"
        Write-Host "Path auto-pasted: $wslPath"
        Write-Host "Original image restored to clipboard!"
        
        # Clean up
        $originalImage.Dispose()
    }
} else {
    Write-Host "No image found in clipboard"
    [System.Windows.Forms.MessageBox]::Show("No image found in clipboard. Copy an image first!", "Screenshot Saver", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
}
