# Steam Shortcut - All flags + Library + cleanup old shortcuts

$steamPath = "C:\Program Files (x86)\Steam\Steam.exe"
$shortcutPath = "$env:USERPROFILE\Desktop\Steam.lnk"

# --- 0. Delete old Steam shortcuts everywhere ---
$oldShortcuts = @(
    "$env:USERPROFILE\Desktop\Steam.lnk"
    "$env:PUBLIC\Desktop\Steam.lnk"
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Steam.lnk"
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Steam.lnk"
)
foreach ($s in $oldShortcuts) {
    if (Test-Path $s) {
        Remove-Item $s -Force
        Write-Host "Deleted: $s" -ForegroundColor Yellow
    }
}

# --- 1. Set default view to Library in sharedconfig.vdf ---
$shared = Get-ChildItem "${env:ProgramFiles(x86)}\Steam\userdata" -Recurse -Filter "sharedconfig.vdf" | Select-Object -First 1
if ($shared) {
    $t = Get-Content $shared.FullName -Raw
    if ($t -match '"SteamDefaultDialog"\s+"[^"]*"') {
        $t = $t -replace '"SteamDefaultDialog"\s+"[^"]*"', '"SteamDefaultDialog"    "#app_games"'
    } else {
        $t = $t -replace '("Steam")', '("Steam")
            {
                "SteamDefaultDialog"    "#app_games"
            }'
    }
    Set-Content $shared.FullName -Value $t -NoNewline
    Write-Host "Library set as default." -ForegroundColor Green
} else {
    Write-Host "sharedconfig.vdf not found!" -ForegroundColor Red
}

# --- 2. Create new shortcut with all flags ---
$flags = @(
    "-nofriendsui"
    "-no-dwrite"
    "-nointro"
    "-nobigpicture"
    "-nofasthtml"
    "-nocrashmonitor"
    "-noshaders"
    "-no-shared-textures"
    "-disablehighdpi"
    "-cef-single-process"
    "-cef-in-process-gpu"
    "-single_core"
    "-disable-winh264"
    "-vrdisable"
    "-cef-disable-breakpad"
    "-cef-disable-d3d11"
    "-cef-disable-gpu-compositing"
    "-cef-disable-gpu"
    "-cef-disable-js-logging"
    "-cef-disable-occlusion"
    "-cef-disable-renderer-restart"
    "-noconsole"
    "-oldtraymenu"
    "-showallbetas"
    "+open steam://open/minigameslist"
) -join " "

$wsh = New-Object -ComObject WScript.Shell
$sc = $wsh.CreateShortcut($shortcutPath)
$sc.TargetPath = $steamPath
$sc.Arguments = $flags
$sc.WorkingDirectory = Split-Path $steamPath
$sc.IconLocation = "$steamPath, 0"
$sc.Save()

Write-Host "Done. New shortcut at: $shortcutPath" -ForegroundColor Green
Write-Host "If Steam is pinned to taskbar, unpin it, launch from Desktop, then re-pin." -ForegroundColor Yellow   
