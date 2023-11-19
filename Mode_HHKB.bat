@echo on

rem Set the source and target directories.
set SOURCE=%~dp0
set MODE=%setting_ThinkPad_HHKB
set TARGET=%LOCALAPPDATA%\Microsoft\PowerToys\Keyboard Manager

rem Use xcopy to copy only the files in the "setting1" directory.
xcopy /y "%SOURCE%%MODE%\*" "%TARGET%" /e /h /k


 :: BatchGotAdmin
 :-------------------------------------
 REM  --> Check for permissions
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
 if '%errorlevel%' NEQ '0' (
     echo Requesting administrative privileges...
     goto UACPrompt
 ) else ( goto gotAdmin )

:UACPrompt
     echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
     echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
     exit /B

:gotAdmin
     if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
     pushd "%CD%"
     CD /D "%~dp0"
 :--------------------------------------

@echo off

taskkill /F /IM powertoys.exe
start "" "C:\Program Files\PowerToys\PowerToys.exe"

start "" "%SOURCE%\Ctrl2Caps_HHKB.reg"

exit