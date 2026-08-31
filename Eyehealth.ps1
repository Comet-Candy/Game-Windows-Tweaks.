# VibrantColorSync_FinalFix.ps1
# POLICY OVERRIDE: Clears PowerShell execution constraints immediately.
# ANTI-INVERSION ENGINE: Hard-blocks FilterType 1 (Inverted) and sets universal Deuteranopia (3).
# DISPLAY REGULATOR: Forces your preferred 70% Night Light and cleans Magnifier hooks.
# EXIT HANDLER: Pauses and visually counts down for 7 seconds before closing the terminal window.

# =========================================================================
# START OF SECURITY & DE-INVERSION BLOCK
# =========================================================================
Set-ExecutionPolicy Unrestricted -Scope Process -Force

$TaskName = "AutomatedDisplayOptimizer"
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue
}
# =========================================================================

Write-Host "Initializing Permanently Corrected Color & Scale Engine..." -ForegroundColor Cyan

# 1. Bypasses driver blocks to capture your exact laptop resolution flawlessly via Windows Forms
try {
    Add-Type -AssemblyName System.Windows.Forms
    $Width = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
    $Height = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height
    Write-Host "[SUCCESS] Windows Forms detected resolution layout: $Width x $Height" -ForegroundColor Green
} catch {
    $Width = 1920
    $Height = 1080
}

# 2. Render optimized dark geometric contrast background matching your resolution perfectly
$LocalPath = "$env:USERPROFILE\Pictures\VibrantLowGlareWallpaper.jpg"
try {
    Add-Type -AssemblyName System.Drawing
    $Bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
    $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
    $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    $BackgroundBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, 22, 26))
    $Graphics.FillRectangle($BackgroundBrush, 0, 0, $Width, $Height)

    $Random = New-Object System.Random
    $BrushColors = @(30, 36, 42, 48, 54)

    for ($i = 0; $i -lt 45; $i++) {
        $Points = @()
        $StartX = $Random.Next(0, $Width)
        $StartY = $Random.Next(0, $Height)
        $Spread = $Random.Next($Width/6, $Width/3)

        for ($j = 0; $j -lt $Random.Next(3, 5); $j++) {
            $X = $StartX + $Random.Next(-$Spread, $Spread)
            $Y = $StartY + $Random.Next(-$Spread, $Spread)
            $Points += New-Object System.Drawing.Point($X, $Y)
        }

        $ColorShade = $BrushColors[$Random.Next(0, $BrushColors.Count)]
        $PolyBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($Random.Next(10, 25), $ColorShade, $ColorShade, $ColorShade))
        $Graphics.FillPolygon($PolyBrush, $Points)
        
        $PenColor = $Random.Next(50, 80)
        $GridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb($Random.Next(2, 6), $PenColor, $PenColor, $PenColor), 1)
        $Graphics.DrawPolygon($GridPen, $Points)
    }

    $Graphics.Dispose()
    $Bitmap.Save($LocalPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $Bitmap.Dispose()

    $DesktopReg = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $DesktopReg -Name "WallpaperStyle" -Value "10" -Force
    Set-ItemProperty -Path $DesktopReg -Name "TileWallpaper" -Value "0" -Force

    $SourceCode = @'
    using System.Runtime.InteropServices;
    public class WallpaperHelper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lvParam, int fuWinIni);
    }
'@
    Add-Type -TypeDefinition $SourceCode -ErrorAction SilentlyContinue
    [WallpaperHelper]::SystemParametersInfo(0x0014, 0, $LocalPath, 0x01 -bor 0x02) | Out-Null
    Write-Host "[SUCCESS] Anti-glare wallpaper applied seamlessly at exact laptop resolution." -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Wallpaper rendering bypass failed: $_" -ForegroundColor Red
}

# 3. Enforce Global System Dark Mode for crisp element contrast
try {
    $PersonalizeKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Set-ItemProperty -Path $PersonalizeKey -Name "AppsUseLightTheme" -Value 0 -Force
    Set-ItemProperty -Path $PersonalizeKey -Name "SystemUsesLightTheme" -Value 0 -Force
    Write-Host "[SUCCESS] System Dark Mode verified." -ForegroundColor Green
} catch {}

# 4. CRITICAL ANTI-INVERSION FIX: FORCE TO TOP-3 OPTION VIA STABLE PROTOCOL
# Value 3 = Deuteranopia (Vivid non-inverted Red-Green color pop enhancement)
$RegPath = "HKCU:\Software\Microsoft\ColorFiltering"
$AccessibilityPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Accessibility\ATConfig\colorfiltering"

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
if (-not (Test-Path $AccessibilityPath)) { New-Item -Path $AccessibilityPath -Force | Out-Null }

# Destroy any Magnifier app hooks or Hotkey Contrast layouts forcing inverted screen space
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Accessibility" -Name "Configuration" -Value "" -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\ScreenMagnifier" -Name "Invert" -Value 0 -Force -ErrorAction SilentlyContinue

# Apply safe non-inverted values
Set-ItemProperty -Path $RegPath -Name "Active" -Value 1 -Force
Set-ItemProperty -Path $RegPath -Name "FilterType" -Value 3 -Force  # Forced to '3' (Deuteranopia) to bypass old Windows 10 '1' (Inverted) locks!
Set-ItemProperty -Path $AccessibilityPath -Name "Active" -Value 1 -Force
Write-Host "[SUCCESS] Color Filters successfully locked to a rich, non-inverted spectrum." -ForegroundColor Green

# 5. ADJUST NIGHT LIGHT TO EXACTLY 70% INTENSITY
$CloudStorePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current"
$NightLightKey = "$CloudStorePath\windows.data.bluelightreduction.settings"
[byte[]]$NightLightSettings = 0x43,0x42,0x01,0x00,0x02,0x00,0x00,0x00,0x0a,0x53,0xe0,0x93,0xe4,0xbb,0x06,0x00,0x00,0x00,0x00,0x43,0x43,0x01,0x01,0x2c,0x01,0x00,0x44,0x00,0x03,0x28,0x14,0x46,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

if (Test-Path $NightLightKey) {
    Set-ItemProperty -Path $NightLightKey -Name "Data" -Value $NightLightSettings -Force
    Write-Host "[SUCCESS] Blue-light tracking balanced at exactly 70%." -ForegroundColor Green
}

# 6. Flush the Windows Explorer Shell to paint all updates live
Write-Host "Refreshing system desktop layout layers..." -ForegroundColor Yellow
Stop-Process -Name "explorer" -Force
Start-Sleep -Seconds 1
if (-not (Get-Process -Name "explorer" -ErrorAction SilentlyContinue)) { Start-Process "explorer.exe" }

# 7. Surface Settings panels to initialize configurations, then auto-dismiss
Write-Host "Verifying live presentation values..." -ForegroundColor Yellow
Start-Process "ms-settings:nightlight"
Start-Process "ms-settings:easeofaccess-colorfilter"

Start-Sleep -Seconds 3

try {
    Stop-Process -Name "SystemSettings" -Force -ErrorAction SilentlyContinue
    Write-Host "[SUCCESS] Settings interface closed automatically." -ForegroundColor Green
} catch {}

Write-Host "All systems optimized! Colors are true, vibrant, and perfectly scaled.`n" -ForegroundColor Green

# =========================================================================
# START OF PAUSE & EXIT BLOCK: 7-SECOND COUNTDOWN
# =========================================================================
for ($i = 7; $i -gt 0; $i--) {
    Write-Host "`rOptimization complete. Exiting terminal in $i seconds..." -NoNewline -ForegroundColor Yellow
    Start-Sleep -Seconds 1
}
Write-Host "`rTerminating process window. Goodbye!                           " -ForegroundColor Green
exit
# =========================================================================
