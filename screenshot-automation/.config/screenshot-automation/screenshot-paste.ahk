; Screenshot Paste for WSL - Simple Version
; Ctrl+V = normal paste (images work in Discord, etc.)
; Ctrl+Shift+V = save image to WSL, put path in clipboard, and paste (for OpenCode)

#Persistent
#SingleInstance Force
Menu, Tray, Tip, Screenshot Helper: Ctrl+Shift+V to paste WSL path

; Ctrl+Shift+V: Save clipboard image to WSL and paste the path, OR paste text if no image
^+v::
    ; Check if clipboard has an image (CF_BITMAP = 2)
    if (DllCall("IsClipboardFormatAvailable", "uint", 2)) {
        ; Has image - save it and paste the path
        wslPath := SaveAndSetClipboard()
        
        if (wslPath != "") {
            ; Small delay then paste
            Sleep, 100
            Send, ^v
        } else {
            ToolTip, Failed to save image
            SetTimer, RemoveToolTip, 2000
        }
    } else {
        ; No image - just do a normal paste (text or whatever is in clipboard)
        Send, ^v
    }
    return

SaveAndSetClipboard() {
    ; PowerShell command to save image and SET CLIPBOARD to the path
    psCommand := "
    (
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    
    if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
        $img = [System.Windows.Forms.Clipboard]::GetImage()
        $distro = (wsl.exe -l -q | Where-Object { $_ -and $_.Trim() -ne '' -and $_ -notlike '*docker*' } | Select-Object -First 1).Trim() -replace '\s+', '' -replace '\x00', ''
        $user = (wsl.exe -d $distro -e whoami).Trim()
        $dir = '\\wsl.localhost\' + $distro + '\home\' + $user + '\.screenshots'
        if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        $ts = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
        $fname = 'screenshot_' + $ts + '.png'
        $fpath = Join-Path $dir $fname
        $img.Save($fpath, [System.Drawing.Imaging.ImageFormat]::Png)
        $latest = Join-Path $dir 'latest.png'
        if (Test-Path $latest) { Remove-Item $latest -Force }
        Copy-Item $fpath $latest -Force
        $img.Dispose()
        
        # Set clipboard to the WSL path
        $wslPath = '/home/' + $user + '/.screenshots/' + $fname
        [System.Windows.Forms.Clipboard]::SetText($wslPath)
        Write-Output $wslPath
    }
    )"
    
    ; Run PowerShell hidden and capture output
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec("powershell.exe -NoProfile -WindowStyle Hidden -Command """ . psCommand . """")
    output := exec.StdOut.ReadAll()
    
    if (output != "") {
        return Trim(RegExReplace(output, "[\r\n]+", ""))
    }
    return ""
}

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
