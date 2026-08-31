#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Removes unused Network Adapter drivers while preserving the active Ethernet connection.
.DESCRIPTION
    This script identifies the currently active physical Ethernet adapter, protects its driver,
    and removes other network driver packages from the driver store using pnputil.
#>

# --- Configuration ---
$ErrorActionPreference = "Continue"
$PauseAtEnd = $true 

# --- Helper: Keep Window Open ---
function Stop-Script {
    param([string]$Message)
    if ($Message) { Write-Host $Message }
    if ($PauseAtEnd) {
        Write-Host "`nPress Enter to exit..." -ForegroundColor Gray
        Read-Host | Out-Null
    }
    exit
}

# --- Header ---
Clear-Host
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "   Network Adapter Driver Cleanup Utility" -ForegroundColor White
Write-Host "   Started: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Gray
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "WARNING: This will remove driver packages from the system." -ForegroundColor Red
Write-Host "Target: Non-active physical Network Adapters." -ForegroundColor White
Write-Host "Ensure you have internet access or drivers saved locally." -ForegroundColor Yellow
Write-Host ""

# --- Step 1: Identify Active Ethernet Driver ---
Write-Host "[1/3] Identifying active Ethernet adapter..." -ForegroundColor Cyan
try {
    # Get active physical Ethernet
    $EthernetAdapter = Get-NetAdapter | Where-Object { 
        $_.Status -eq 'Up' -and 
        $_.InterfaceDescription -notmatch 'Wireless|Wi-Fi|Bluetooth|Virtual|TAP|TUN|Loopback|Kernel|Panda' 
    } | Select-Object -First 1

    if (-not $EthernetAdapter) {
        throw "No active physical Ethernet adapter found. Aborting to prevent network loss."
    }

    Write-Host "  Found: $($EthernetAdapter.InterfaceDescription)" -ForegroundColor Green
    Write-Host "  MAC: $($EthernetAdapter.MacAddress)" -ForegroundColor Gray

    # Map to PnP Device using Instance ID match or Name match
    $PnPDevice = Get-PnpDevice -Class Net | Where-Object { 
        $_.Status -eq 'OK' -and $_.FriendlyName -eq $EthernetAdapter.InterfaceDescription
    } | Select-Object -First 1

    if (-not $PnPDevice) { throw "Could not map network adapter to a PnP Device." }

    # Robust INF retrieval using CimInstance properties instead of DEVPKEY literal strings
    $DeviceDetails = Get-CimInstance -ClassName Win32_PnPSignedDriver | Where-Object { $_.DeviceID -eq $PnPDevice.InstanceId }
    $ProtectedInf = $DeviceDetails.InfName

    if (-not $ProtectedInf) { throw "Could not determine the INF filename for the active driver." }
    
    Write-Host "  Protected Driver: $ProtectedInf" -ForegroundColor Green
}
catch {
    Write-Host "  CRITICAL ERROR: $_" -ForegroundColor Red
    Stop-Script
}

# --- Step 2: Enumerate Targets ---
Write-Host "`n[2/3] Scanning for removable third-party drivers..." -ForegroundColor Cyan

# Gather all network drivers currently in the store via PnPUtil to avoid deleting core Windows system components
$OemDrivers = pnputil /enum-drivers | Out-String
$OemDriverMatches = [regex]::Matches($OemDrivers, 'Published Name:\s+(oem\d+\.inf)[\s\S]*?Class Name:\s+Net')

$ProtectedInfLower = $ProtectedInf.ToLower()
$Targets = @()

foreach ($Match in $OemDriverMatches) {
    $InfName = $Match.Groups[1].Value
    if ($InfName.ToLower() -eq $ProtectedInfLower) { continue }
    $Targets += $InfName
}

if ($Targets.Count -eq 0) {
    Write-Host "  No other third-party network adapter drivers found to remove." -ForegroundColor Yellow
    Stop-Script
}

Write-Host "  Found $($Targets.Count) third-party driver package(s) marked for removal." -ForegroundColor Yellow

# --- Confirmation ---
Write-Host "`nDo you want to proceed with removal? (Y/N)" -ForegroundColor Yellow
$confirmation = Read-Host
if ($confirmation -notmatch '^[Yy]$') {
    Write-Host "Operation cancelled by user." -ForegroundColor Gray
    Stop-Script
}

# --- Step 3: Removal Process ---
Write-Host "`n[3/3] Starting removal process..." -ForegroundColor Cyan
$RemovedCount = 0
$FailedCount = 0

foreach ($DriverInf in $Targets) {
    Write-Host "  Removing driver package: $DriverInf..." -ForegroundColor Cyan
    
    try {
        # /delete-driver target /uninstall /force removes third party driver store packages safely
        $Result = pnputil /delete-driver $DriverInf /uninstall /force 2>&1
        
        if ($LASTEXITCODE -eq 0 -or $Result -like "*deleted successfully*" -or $Result -like "*No matching driver packages found*") {
            Write-Host "    -> Success." -ForegroundColor Green
            $RemovedCount++
        } else {
            Write-Host "    -> Warning: pnputil returned code $LASTEXITCODE. Driver may be required by system hardware." -ForegroundColor Yellow
            $FailedCount++
        }
    }
    catch {
        Write-Host "    -> Failed: $_" -ForegroundColor Red
        $FailedCount++
    }
}

# --- Summary ---
Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "   Cleanup Complete" -ForegroundColor White
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Drivers Removed: $RemovedCount" -ForegroundColor Green
Write-Host "Drivers Skipped/In-Use: $FailedCount" -ForegroundColor Yellow
Write-Host "Active Driver Preserved: $ProtectedInf" -ForegroundColor Green

Stop-Script
