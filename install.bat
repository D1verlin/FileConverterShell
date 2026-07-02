@echo off
:: Check for administrative permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :admin
) else (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:admin
cd /d "%~dp0"
echo Running setup.ps1 with Administrator privileges...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
pause
