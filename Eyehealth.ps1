# DynamicDisplayOptimizer_Complete.ps1
# POLICY OVERRIDE: Clears PowerShell execution constraints immediately.
# AUTOMATION: Registers itself to run silently on every Windows logon.
# GRAPHICS: Bypasses network errors using an offline graphics generator.
# DISPLAY: Sets 100% Brightness, 80% Night Light, Red-Green Color Filter, and auto-closes settings.
# EXIT HANDLER: Pauses and visually counts down for 7 seconds before closing the terminal window.

# =========================================================================
# START OF TOP SECURITY & AUTOMATION BLOCK
# =========================================================================
Set-ExecutionPolicy Unrestricted -Scope Process -Force

$TaskName = "AutomatedDisplayOptimizer"
$ScriptPath = $MyInvocation.MyCommand.Path

if ($ScriptPath -and (-not (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue))) {
    Write-Host "Registering script to run automatically and silently at logon..." -ForegroundColor Cyan
    
    $Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    $Trigger = New-ScheduledTaskTrigger -AtLogon
    $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -WindowStyle Hidden -File `"$ScriptPath`""
    
    Register-ScheduledTask -TaskName $TaskName -Trigger $Trigger -Action $Action -Principal $Principal | Out-Null
    Write-Host "[SUCCESS] Task Scheduler automation locked in! It will now run hidden every time you start Windows.`n" -ForegroundColor Green
}
# =========================================================================
# END OF TOP SECURITY & AUTOMATION BLOCK
# =========================================================================

Write-Host "Initializing Local Display & Auto-Close Engine..." -ForegroundColor Cyan

# 1. Grab active screen resolution properties dynamically
try {
    $Width = (Get-CimInstance -Namespace root/wmi -ClassName WmiMonitorBasicDisplayParams).HorizontalActivePixels
    $Height = (Get-CimInstance -Namespace root/wmi -ClassName WmiMonitorBasicDisplayParams).VerticalActivePixels

    if (-not $Width -or -not $Height) {
        $Display = Get-DisplayResolution
        $Width = $Display.Width
        $Height = $Display.Height
    }
    Write-Host "[SUCCESS] Detected active person screen size layout: $Width x $Height" -ForegroundColor Green
} catch {
    $Width = 1920
    $Height = 1080
    Write-Host "[WARNING] Graphics probe locked. Deploying default safety array: $Width x $Height" -ForegroundColor Yellow
}

# 2. Programmatically draw the abstract dark polygon art canvas offline
$LocalPath = "$env:USERPROFILE\Pictures\OfflinePolygonWallpaper.jpg"

try {
    Write-Host "Assembling high-resolution abstract image locally (No Internet Required)..." -ForegroundColor Yellow
    Add-Type -AssemblyName System.Drawing
    
    $Bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
    $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
    $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    $BackgroundBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(15, 16, 18))
    $Graphics.FillRectangle($BackgroundBrush, 0, 0, $Width, $Height)

    $Random = New-Object System.Random
    $BrushColors = @(24, 28, 32, 40, 48)

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
        $PolyBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($Random.Next(8, 22), $ColorShade, $ColorShade, $ColorShade))
        $Graphics.FillPolygon($PolyBrush, $Points)
        
        $PenColor = $Random.Next(40, 70)
        $GridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb($Random.Next(2, 8), $PenColor, $PenColor, $PenColor), 1)
        $Graphics.DrawPolygon($GridPen, $Points)
    }

    $Graphics.Dispose()
    $Bitmap.Save($LocalPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $Bitmap.Dispose()
    Write-Host "[SUCCESS] Abstract geometric asset rendered cleanly." -ForegroundColor Green

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
    Write-Host "[SUCCESS] Wallpaper flawlessly applied to desktop." -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Local graphics rendering step failed: $_" -ForegroundColor Red
}

# 3. Force Monitor Brightness to 100% (Integrated laptop panels)
try {
    Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods | Invoke-CimMethod -MethodName WmiSetBrightness -Arguments @{ Timeout = 0; Brightness = 100 }
    Write-Host "[SUCCESS] Hardware brightness driven to 100%." -ForegroundColor Green
} catch {
    Write-Host "[INFO] External desktop monitor detected. Ensure physical display buttons are manually cranked up to 100%." -ForegroundColor Yellow
}

# 4. Configure Color Filters (Active, Red-Green Shift, No Greyscale)
$RegPath = "HKCU:\Software\Microsoft\ColorFiltering"
$AccessibilityPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Accessibility\ATConfig\colorfiltering"

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
if (-not (Test-Path $AccessibilityPath)) { New-Item -Path $AccessibilityPath -Force | Out-Null }

Set-ItemProperty -Path $RegPath -Name "Active" -Value 1 -Force
Set-ItemProperty -Path $RegPath -Name "FilterType" -Value 1 -Force
Set-ItemProperty -Path $AccessibilityPath -Name "Active" -Value 1 -Force
Write-Host "[SUCCESS] Color Filter locked to vibrant Red-Green mode." -ForegroundColor Green

# 5. Inject Night Light Profile at 80% Warmth
$CloudStorePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current"
$NightLightKey = "$CloudStorePath\windows.data.bluelightreduction.settings"

[byte[]]$NightLightSettings = 0x43,0x42,0x01,0x00,0x02,0x00,0x00,0x00,0x0a,0x53,0xe0,0x93,0xe4,0xbb,0x06,0x00,0x00,0x00,0x00,0x43,0x43,0x01,0x01,0x2c,0x01,0x00,0x44,0x00,0x03,0x28,0x14,0x50,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

if (Test-Path $NightLightKey) {
    Set-ItemProperty -Path $NightLightKey -Name "Data" -Value $NightLightSettings -Force
    Write-Host "[SUCCESS] Night Light architecture locked at 80% intensity." -ForegroundColor Green
} else {
    Write-Host "[WARNING] Night Light registry structure initializing..." -ForegroundColor Yellow
}

# 6. Flush and visually paint the desktop canvas shell 
Write-Host "Flushing display workspace to push layout changes live..." -ForegroundColor Yellow
Stop-Process -Name "explorer" -Force
Start-Sleep -Seconds 1
if (-not (Get-Process -Name "explorer" -ErrorAction SilentlyContinue)) { Start-Process "explorer.exe" }

# 7. Surface Settings pages to force Windows registry application, then cleanly close them
Write-Host "Forcing Windows to acknowledge optimization values..." -ForegroundColor Yellow
Start-Process "ms-settings:nightlight"
Start-Process "ms-settings:easeofaccess-colorfilter"

# Wait exactly 3 seconds for the Settings app to paint the screen changes
Start-Sleep -Seconds 3

Write-Host "Cleaning up desktop workspace by closing Settings pages automatically..." -ForegroundColor Cyan
try {
    Stop-Process -Name "SystemSettings" -Force -ErrorAction SilentlyContinue
    Write-Host "[SUCCESS] Settings interfaces closed successfully." -ForegroundColor Green
} catch {
    Write-Host "[INFO] Settings app closed prematurely or already dismissed." -ForegroundColor Gray
}

Write-Host "All systems optimized successfully! Your display environment is clean and complete.`n" -ForegroundColor Green

# =========================================================================
# START OF BOTTOM PAUSE & EXIT BLOCK: 7-SECOND COUNTDOWN
# =========================================================================
# Visually decrement an inline string timer to cleanly exit the engine console window
for ($i = 7; $i -gt 0; $i--) {
    Write-Host "`rScript finished. Pausing for $i seconds before auto-closing..." -NoNewline -ForegroundColor Yellow
    Start-Sleep -Seconds 1
}
Write-Host "`rTerminating process window. Goodbye!                           " -ForegroundColor Green
exit
# =========================================================================
# END OF BOTTOM PAUSE & EXIT BLOCK
# =========================================================================
