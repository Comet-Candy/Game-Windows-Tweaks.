$SteamDir = "C:\Program Files (x86)\Steam"
$SteamExe = "$SteamDir\steam.exe"
$ConfigPath = "$SteamDir\config\config.vdf"
$Flags = "-nofriendsui -no-dwrite -nointro -nobigpicture -nofasthtml -nocrashmonitor -noshaders -no-shared-textures -disablehighdpi -cef-single-process -cef-in-process-gpu -single_core -disable-winh264 -vrdisable -cef-disable-breakpad -cef-disable-d3d11 -cef-disable-gpu-compositing -cef-disable-gpu -cef-disable-js-logging -cef-disable-occlusion -cef-disable-renderer-restart -noconsole -oldtraymenu -showallbetas +open steam://open/minigameslist"
$ShortcutPath = "$env:USERPROFILE\Desktop\Steam.lnk"

# Kill Steam
Stop-Process -Name "steam" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "steamwebhelper" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3

# Create/overwrite desktop shortcut
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $SteamExe
$Shortcut.Arguments = $Flags
$Shortcut.WorkingDirectory = $SteamDir
$Shortcut.IconLocation = "$SteamExe,0"
$Shortcut.Save()

# Disable "Scale text and icons to match monitor settings" in config.vdf
if (Test-Path $ConfigPath) {
    $c = Get-Content $ConfigPath -Raw
    if ($c -match '"HighDPISupport"\s+"[0-9]+"') {
        $c = $c -replace '"HighDPISupport"\s+"[0-9]+"', '"HighDPISupport"    "0"'
    } else {
        $c = $c -replace '("config"\s*\r?\n\s*\{)', ('$1' + "`r`n`"HighDPISupport`"    `"0`"")
    }
    Set-Content $ConfigPath $c -NoNewline
}

# Set StartupPage to Library in localconfig.vdf
$localFiles = Get-ChildItem "$SteamDir\userdata" -Recurse -Filter "localconfig.vdf"
foreach ($f in $localFiles) {
    $c = Get-Content $f.FullName -Raw
    if ($c -match '"StartupPage"\s+"[0-9]+"') {
        $c = $c -replace '"StartupPage"\s+"[0-9]+"', '"StartupPage"    "1"'
    } else {
        $c = $c -replace '("Steam"\s*\r?\n\s*\{)', ('$1' + "`r`n        `"StartupPage`"    `"1`"")
    }
    Set-Content $f.FullName $c -NoNewline
}

# Restart Steam
Start-Process $SteamExe -ArgumentList $Flags -WorkingDirectory $SteamDir

Write-Host "Done. Steam restarted with all settings applied." -ForegroundColor Green   
