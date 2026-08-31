# 1. Download the image with the corrected URL
$imageUrl = "https://r4.wallpaperflare.com/wallpaper/543/404/63/abstract-polygon-dark-bw-wallpaper-406075d95f368ec3789f6786bba604d8.jpg"
$localPath = "$env:USERPROFILE\Pictures\wallpaper.jpg"

Write-Host "Downloading wallpaper..."
Invoke-WebRequest -Uri $imageUrl -OutFile $localPath

# 2. Set the image as the desktop background
Write-Host "Setting desktop background..."
$code = @'
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lvParam, int fuWinIni);
}
'@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
[Wallpaper]::SystemParametersInfo(0x0014, 0, $localPath, 0x0001 -bor 0x0002)

# 3. Change Night Light strength value to 80
Write-Host "Adjusting Night Light value to 80..."
$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default`$windows.data.bluelightreduction.settings\windows.data.bluelightreduction.settings"
if (Test-Path $Path) {
    $Settings = (Get-ItemProperty $Path).Data
    # Modifies the specific 14th byte to decimal 80 for the strength slider
    $Settings[14] = 80 
    Set-ItemProperty -Path $Path -Name Data -Value $Settings
}

# 4. Set screen brightness to 100%
Write-Host "Setting screen brightness to 100%..."
Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods | Invoke-CimMethod -MethodName WmiSetBrightness -Arguments @{ Timeout = 0; Brightness = 100 }

Write-Host "All tasks completed successfully!"
