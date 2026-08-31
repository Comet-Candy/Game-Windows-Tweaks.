Set-ExecutionPolicy Unrestricted -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
if (Get-ScheduledTask -TaskName "AutomatedDisplayOptimizer" -ErrorAction SilentlyContinue) { Unregister-ScheduledTask -TaskName "AutomatedDisplayOptimizer" -Confirm:$false }
try { Add-Type -AssemblyName System.Windows.Forms; $W = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width; $H = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height } catch { $W = 1920; $H = 1080 }
$Img = "$env:USERPROFILE\Pictures\VibrantLowGlareWallpaper.jpg"
$Url = "https://r2.dev"
try {
    $TargetDir = Split-Path -Path $Img
    if (-not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null }
    $UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    try { Invoke-WebRequest -Uri $Url -OutFile $Img -UserAgent $UA -TimeoutSec 30 -ErrorAction Stop } catch { (New-Object System.Net.WebClient).DownloadFile($Url, $Img) }
    Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallpaperStyle" "10" -Force; Set-ItemProperty "HKCU:\Control Panel\Desktop" "TileWallpaper" "0" -Force
    $WpCode = 'using System.Runtime.InteropServices; public class Wp { [DllImport("user32.dll", CharSet=CharSet.Auto)] public static extern int SystemParametersInfo(int a, int p, string v, int f); }'
    Add-Type -TypeDefinition $WpCode -ErrorAction SilentlyContinue; [Wp]::SystemParametersInfo(0x0014, 0, $Img, 3) | Out-Null
} catch {}
try { Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0 -Force; Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0 -Force } catch {}
try { Set-ItemProperty "HKCU:\Control Panel\Desktop" "FontSmoothing" "2" -Force; Set-ItemProperty "HKCU:\Control Panel\Desktop" "FontSmoothingType" "2" -Force } catch {}
try { Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods | Invoke-CimMethod -MethodName WmiSetBrightness -Arguments @{ Timeout = 0; Brightness = 100 } } catch {}
$Cs = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\windows.data.bluelightreduction.settings"
[byte[]]$Nl = 0x43,0x42,0x01,0x00,0x02,0x00,0x00,0x00,0x0a,0x53,0xe0,0x93,0xe4,0xbb,0x06,0x00,0x00,0x00,0x00,0x43,0x43,0x01,0x01,0x2c,0x01,0x00,0x44,0x00,0x03,0x28,0x14,0x50,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
if (Test-Path $Cs) { Set-ItemProperty $Cs "Data" $Nl -Force }
Stop-Process -Name "explorer" -Force; Start-Sleep -Seconds 1; if (-not (Get-Process -Name "explorer" -ErrorAction SilentlyContinue)) { Start-Process "explorer.exe" }
Start-Process "ms-settings:nightlight"; Start-Sleep -Seconds 3
try { Stop-Process -Name "SystemSettings" -Force -ErrorAction SilentlyContinue } catch {}
for ($i = 7; $i -gt 0; $i--) { Write-Host "`rDone! Exiting in $i..." -NoNewline -ForegroundColor Green; Start-Sleep -Seconds 1 }; exit
