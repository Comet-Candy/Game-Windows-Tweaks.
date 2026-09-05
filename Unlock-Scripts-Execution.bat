@echo off
setlocal EnableExtensions

:: ===== UAC Elevation =====
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting admin privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
if '%1'=='UACdone' ( shift & goto gotAdmin )
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "UACdone", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
pushd "%CD%"
CD /D "%~dp0"

:: ===== Resolve PowerShell path =====
set "PS_PATH="
for %%i in (
    "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
    "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
) do if exist %%i set "PS_PATH=%%~i"

if "%PS_PATH%"=="" (
    echo [ERROR] PowerShell not found.
    pause
    exit /B 1
)

:: ===== Menu =====
:menu
cls
echo  ╔══════════════════════════════════════════╗
echo  ║     PowerShell NUCLEAR UNLOCK v2.0      ║
echo  ╚══════════════════════════════════════════╝
echo.
echo    1. FULL UNLOCK  (all restrictions removed)
echo    2. FULL LOCK    (restore defaults)
echo    3. Status Check
echo    4. Exit
echo.
set /p choice=Select an option: 
if "%choice%"=="1" goto unlock
if "%choice%"=="2" goto lock
if "%choice%"=="3" goto status
if "%choice%"=="4" goto end
goto menu

:: ============================================================
:: FULL UNLOCK — removes every known PowerShell restriction
:: ============================================================
:unlock
cls
echo  Applying maximum permissiveness...
echo.

:: ---------- 1. Execution Policy: ALL scopes ----------
echo  [1/8] Setting ExecutionPolicy = Unrestricted (all scopes)...

:: LocalMachine (64-bit)
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1
:: LocalMachine (32-bit / WOW64)
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1
:: CurrentUser
reg add "HKCU\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1
:: MachinePolicy (GPO-level override — highest priority)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnableScripts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1
:: UserPolicy (user-level GPO override)
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnableScripts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1

:: ---------- 2. PowerShell Core (pwsh) policy ----------
echo  [2/8] Setting PowerShell Core policy...
reg add "HKLM\SOFTWARE\Microsoft\PowerShellCore\1\ShellIds\Microsoft.PowerShellCore" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\PowerShellCore\1\ShellIds\Microsoft.PowerShellCore" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1

:: ---------- 3. Kill Constrained Language Mode ----------
echo  [3/8] Removing Constrained Language Mode (__PSLockdownPolicy)...
:: Delete from SYSTEM environment (machine-wide)
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "__PSLockdownPolicy" /f >nul 2>&1
:: Delete from USER environment
reg delete "HKCU\Environment" /v "__PSLockdownPolicy" /f >nul 2>&1
:: Clear from current process
set "__PSLockdownPolicy="

:: ---------- 4. Remove WDAC / AppLocker policies ----------
echo  [4/8] Removing WDAC / AppLocker policies...
:: WDAC policies
if exist "C:\ProgramData\Microsoft\Windows\CodeIntegrity\CiPolicies" (
    rmdir /s /q "C:\ProgramData\Microsoft\Windows\CodeIntegrity\CiPolicies" 2>nul
)
if exist "C:\ProgramData\Microsoft\Windows\CodeIntegrity\Broker" (
    rmdir /s /q "C:\ProgramData\Microsoft\Windows\CodeIntegrity\Broker" 2>nul
)
:: AppLocker
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SrpV2" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppLocker" /f >nul 2>&1
:: Smart App Control (Windows 11 22H2+)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d 0 /f >nul 2>&1

:: ---------- 5. Disable PowerShell logging/audit ----------
echo  [5/8] Disabling PowerShell logging...
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\3\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\3\ScriptBlockForLogging" /v "EnableScriptBlockForLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\3\ModuleLogging" /v "EnableModuleLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockForLogging" /v "EnableScriptBlockForLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v "EnableModuleLogging" /t REG_DWORD /d 0 /f >nul 2>&1

:: ---------- 6. Prevent future MOTW (Mark of the Web) ----------
echo  [6/8] Disabling Mark-of-the-Web tagging...
:: Never save zone info (system-wide)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d 1 /f >nul 2>&1

:: ---------- 7. Set double-click handler with Bypass ----------
echo  [7/8] Setting .ps1 double-click handler...
reg add "HKCR\Applications\powershell.exe\shell\open\command" /ve /t REG_SZ /d "\"%PS_PATH%\" -NoLogo -ExecutionPolicy Bypass -File \"%%1\"" /f >nul 2>&1

:: ---------- 8. System-wide MOTW scrub (existing files) ----------
echo  [8/8] Scrubbing Zone.Identifier from ALL files on C:\ ...
echo         (this may take a few minutes)
"%PS_PATH%" -NoProfile -ExecutionPolicy Bypass -Command "
    $count = 0
    Get-ChildItem -Path 'C:\' -Recurse -File -Force -ErrorAction SilentlyContinue |
        ForEach-Object {
            try {
                $stream = Get-Item -LiteralPath $_.FullName -Stream 'Zone.Identifier' -ErrorAction Stop
                Remove-Item -LiteralPath $_.FullName -Stream 'Zone.Identifier' -Force -ErrorAction SilentlyContinue
                $count++
            } catch {}
        }
    Write-Host ""
    Write-Host \"  Done. Removed MOTW from $count file(s).\"
"

echo.
echo  ══════════════════════════════════════════
echo   [OK] ALL RESTRICTIONS REMOVED
echo   - ExecutionPolicy: Unrestricted (all scopes)
echo   - Constrained Language Mode: OFF
echo   - WDAC / AppLocker: REMOVED
echo   - Smart App Control: DISABLED
echo   - MOTW: Scrubbed + future tagging OFF
echo   - Script/Module Logging: DISABLED
echo   - Double-click: Bypass mode
echo  ══════════════════════════════════════════
echo.
pause
goto menu

:: ============================================================
:: FULL LOCK — restore restrictive defaults
:: ============================================================
:lock
cls
echo  Restoring restrictive defaults...

reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Restricted" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Restricted" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnableScripts" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "ExecutionPolicy" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /f >nul 2>&1
reg delete "HKCR\Applications\powershell.exe\shell\open" /f >nul 2>&1

echo.
echo  [OK] Restored to Restricted.
echo.
pause
goto menu

:: ============================================================
:: STATUS CHECK
:: ============================================================
:status
cls
echo  ══════════════════════════════════════════
echo   PowerShell Status Report
echo  ══════════════════════════════════════════
echo.
"%PS_PATH%" -NoProfile -ExecutionPolicy Bypass -Command "
    Write-Host '  Execution Policy (effective):'
    Write-Host ('    ' + (Get-ExecutionPolicy).ToString())
    Write-Host ''
    Write-Host '  Execution Policy (all scopes):'
    Get-ExecutionPolicy -List | Format-Table -AutoSize | Out-String | ForEach-Object { Write-Host ('    ' + $_) }
    Write-Host '  Language Mode:'
    Write-Host ('    ' + $ExecutionContext.SessionState.LanguageMode)
    Write-Host ''
    Write-Host '  __PSLockdownPolicy:'
    $val = [Environment]::GetEnvironmentVariable('__PSLockdownPolicy', 'Machine')
    if ($val) { Write-Host ('    ' + $val) } else { Write-Host '    Not set (good)' }
    Write-Host ''
    Write-Host '  WDAC Policy:'
    try {
        $cip = Get-CiPolicy -Effective -ErrorAction Stop
        Write-Host ('    ' + $cip.Name)
    } catch { Write-Host '    None active (good)' }
"
echo.
pause
goto menu

:end
endlocal
exit /B   
