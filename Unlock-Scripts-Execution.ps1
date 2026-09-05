# ============================================================
# FULL UNLOCK — Bypass for everything
# ============================================================

$ErrorActionPreference = "SilentlyContinue"

Write-Host ""
Write-Host "  Applying full unlock (Bypass)..."
Write-Host ""

# --- 1. Execution Policy: Bypass at all scopes ---
Write-Host "  [1/7] Execution Policy -> Bypass (all scopes)"

$polHKLM = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell"
$polHKCU = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\PowerShell"

New-Item -Path $polHKLM -Force | Out-Null
New-Item -Path $polHKCU -Force | Out-Null

Set-ItemProperty -Path $polHKLM -Name "ExecutionPolicy" -Value "Bypass"
Set-ItemProperty -Path $polHKCU -Name "ExecutionPolicy" -Value "Bypass"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" -Name "ExecutionPolicy" -Value "Bypass"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" -Name "ExecutionPolicy" -Value "Bypass"

# --- 2. EnableScripts ---
Write-Host "  [2/7] EnableScripts -> 1"
Set-ItemProperty -Path $polHKLM -Name "EnableScripts" -Value 1 -Type DWord
Set-ItemProperty -Path $polHKCU -Name "EnableScripts" -Value 1 -Type DWord

# --- 3. Constrained Language Mode: OFF ---
Write-Host "  [3/7] Constrained Language Mode -> OFF"
[Environment]::SetEnvironmentVariable("__PSLockdownPolicy", $null, "Machine")
[Environment]::SetEnvironmentVariable("__PSLockdownPolicy", "0", "Machine")

# --- 4. Smart App Control: OFF ---
Write-Host "  [4/7] Smart App Control -> OFF"
$ciPolicy = "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy"
New-Item -Path $ciPolicy -Force | Out-Null
Set-ItemProperty -Path $ciPolicy -Name "VerifiedAndReputablePolicyState" -Value 0 -Type DWord

# --- 5. WDAC / AppLocker: Remove ---
Write-Host "  [5/7] WDAC / AppLocker -> Removed"
Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -Name "SIPEnabled" -Force
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CodeIntegrity\PolStore" -Recurse -Force

# --- 6. Script/Module Logging: DISABLED ---
Write-Host "  [6/7] Script/Module Logging -> Disabled"
$logPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging"
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
)
foreach ($p in $logPaths) { New-Item -Path $p -Force | Out-Null }

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockInvocationLogging" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" -Name "EnableTranscripting" -Value 0 -Type DWord

# --- 7. MOTW: Disable future tagging ---
Write-Host "  [7/7] MOTW -> Future tagging OFF"
$motwHKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments"
$motwHKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments"
New-Item -Path $motwHKLM -Force | Out-Null
New-Item -Path $motwHKCU -Force | Out-Null
Set-ItemProperty -Path $motwHKLM -Name "SaveZoneIdentifier" -Value 1 -Type DWord
Set-ItemProperty -Path $motwHKCU -Name "SaveZoneIdentifier" -Value 1 -Type DWord

# --- Double-click .ps1 -> Bypass mode ---
$psPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$shellOpen = "HKCR:\Applications\powershell.exe\shell\open\command"
New-Item -Path $shellOpen -Force | Out-Null
Set-ItemProperty -Path $shellOpen -Name "" -Value "`"$psPath`" -NoProfile -ExecutionPolicy Bypass -NoExit -File `"%1`""

# --- Done ---
Write-Host ""
Write-Host "  ======================================"
Write-Host "   [OK] ALL RESTRICTIONS REMOVED"
Write-Host "   - ExecutionPolicy: Bypass (all scopes)"
Write-Host "   - Constrained Language Mode: OFF"
Write-Host "   - Smart App Control: DISABLED"
Write-Host "   - WDAC / AppLocker: REMOVED"
Write-Host "   - MOTW: Future tagging OFF"
Write-Host "   - Script/Module Logging: DISABLED"
Write-Host "   - Double-click: Bypass mode"
Write-Host "  ======================================"
Write-Host ""
Write-Host "  NOTE: Restart required for CLM & Smart App Control changes."
Write-Host ""
Read-Host "  Press Enter to exit"   
