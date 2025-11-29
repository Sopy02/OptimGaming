@echo off
:: Cerere drepturi de administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Acest script trebuie rulat ca Administrator.
    echo Apasa orice tasta pentru a iesi...
    pause >nul
    exit /b
)

echo.
echo Dezactivare servicii de telemetrie si alte servicii inutile...
echo.

sc config DiagTrack start= disabled
sc stop DiagTrack >nul 2>&1

sc config Spooler start= disabled
sc stop Spooler >nul 2>&1

sc config WSearch start= disabled
sc stop WSearch >nul 2>&1

sc config SysMain start= disabled
sc stop SysMain >nul 2>&1

sc config DoSvc start= disabled
sc stop DoSvc >nul 2>&1

echo.
echo Registry tweaks - dezactivare telemetrie...
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ConnectedUserExperiences" /v Disable /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f

echo.
echo Dezactivare task-uri programate de telemetrie...
echo.

schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable

echo.
echo Toate operatiunile au fost efectuate cu succes!
echo Pentru a reactiva serviciile mai tarziu, ruleaza comanda:
echo sc config NumeServiciu start= auto  +  sc start NumeServiciu
echo.
pause
