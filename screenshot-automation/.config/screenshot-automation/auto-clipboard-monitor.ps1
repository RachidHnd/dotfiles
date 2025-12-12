# True automatic clipboard monitor using Windows events
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
            Write-Host "Auto-detected WSL distribution: $WslDistro"
        }
    }
    
    # Get the actual WSL username instead of Windows username
    $WslUsername = wsl.exe -d $WslDistro -e whoami
    $WslUsername = $WslUsername.Trim()
    $SaveDirectory = "\\wsl.localhost\$WslDistro\home\$WslUsername\.screenshots"
}

if (!(Test-Path $SaveDirectory)) {
    New-Item -ItemType Directory -Path $SaveDirectory -Force | Out-Null
}

Write-Host "WINDOWS-TO-WSL2 SCREENSHOT AUTOMATION STARTED"
Write-Host "Auto-saving images to: $SaveDirectory"
Write-Host "Press Ctrl+C to stop"



Write-Host "Monitoring clipboard events and directory changes..."
$previousHash = $null
$lastFileTime = Get-Date

# Store the WSL path without modifying clipboard
$global:LatestImagePath = $null

while ($true) {
    try {
        Start-Sleep -Milliseconds 500
        
        if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
            $image = [System.Windows.Forms.Clipboard]::GetImage()
            if ($image) {
                $ms = New-Object System.IO.MemoryStream
                $image.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
                $imageBytes = $ms.ToArray()
                $ms.Dispose()
                $currentHash = [System.BitConverter]::ToString([System.Security.Cryptography.SHA256]::Create().ComputeHash($imageBytes))
                
                if ($currentHash -ne $previousHash) {
                    Write-Host "New image detected in clipboard"
                    
                    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
                    $filename = "screenshot_$timestamp.png"
                    $filepath = Join-Path $SaveDirectory $filename
                    $image.Save($filepath, [System.Drawing.Imaging.ImageFormat]::Png)
                    
                    $latestPath = Join-Path $SaveDirectory "latest.png"
                    if (Test-Path $latestPath) { Remove-Item $latestPath -Force }
                    Copy-Item $filepath $latestPath -Force
                    
                    # Create full path for WSL2 - store but don't modify clipboard
                    $wslPath = "/home/$WslUsername/.screenshots/$filename"
                    $global:LatestImagePath = $wslPath
                    
                    Write-Host "AUTO-SAVED: $filename"
                    Write-Host "WSL path available: $wslPath"
                    Write-Host "Windows clipboard still has the image for pasting!"
                    
                    $previousHash = $currentHash
                }
                $image.Dispose()
            }
        }
        
        # Also check for new files in the directory (for drag-drop screenshots)
        $currentTime = Get-Date
        $newFiles = Get-ChildItem $SaveDirectory -Filter "*.png" | Where-Object { 
            $_.LastWriteTime -gt $lastFileTime -and $_.Name -ne "latest.png" 
        }
        
        if ($newFiles) {
            foreach ($file in $newFiles) {
                # Create full path for WSL2 - store but don't modify clipboard
                $wslPath = "/home/$WslUsername/.screenshots/$($file.Name)"
                $global:LatestImagePath = $wslPath
                Copy-Item $file.FullName (Join-Path $SaveDirectory "latest.png") -Force
                
                Write-Host "NEW FILE DETECTED: $($file.Name)"
                Write-Host "WSL path available: $wslPath"
            }
            $lastFileTime = $currentTime
        }
        
    } catch {
        Write-Warning "Error in main loop: $_"
        Start-Sleep -Milliseconds 1000
    }
}
