@ECHO off
TITLE Uninstaller
::: Created By Sam Thomas
::: Version 1.1.1
::: https://github.com/Exkli/IPConfigurator

::: Admin Check
if '%errorlevel%' NEQ '0' (
    echo Requesting Admin access...
    goto goUAC 
)   else ( goto goADMIN
)

:goUAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:goADMIN
    pushd "%CD%"
    CD /D "%~dp0"
net session
if errorlevel 1 (
    goto Admin
) else ( goto start
)
:start
cls
ECHO Version 1.0.0
ECHO  ศอออออออออออออผ
ECHO  ศ	     Made By Sam 		   ผ
ECHO  ศอออออออออออออผ
ECHO.
ECHO.
SET /p un=Do you want to uninstall everything including the installer?(Y/N) or type C to cancel - 

IF /I "%un%"=="n" GOTO Uninstall 
IF /I "%un%"=="y" GOTO Uninstall All
IF /I "%un%"=="c" exit

:Uninstall
del "C:\Program Files\IPConfigurator\autoupdater.bat"
del "C:\Program Files\IPConfigurator\IP Configurator.bat"
del "C:\Program Files\IPConfigurator\readme.txt"
del "C:\Program Files\IPConfigurator\Version Info.txt"
del "C:\Program Files\IPConfigurator\IPConfigurator\IP Configurator - Shortcut.lnk"
goto Delete

:Uninstall All
del "C:\Program Files\IPConfigurator\autoupdater.bat"
del "C:\Program Files\IPConfigurator\IP Configurator.bat"
del "C:\Program Files\IPConfigurator\readme.txt"
del "C:\Program Files\IPConfigurator\Version Info.txt"
del "C:\Program Files\IPConfigurator\IPConfigurator\IP Configurator - Shortcut.lnk"
del "C:\Program Files\IPConfigurator\IP Installer.bat"
goto Delete

:Admin
cls
ECHO.
ECHO PLEASE RUN AS ADMINISTRATOR
pause

:Delete
del "C:\Program Files\IPConfigurator\uninstall.bat"
GOTO end
:end
ECHO Uninstall Complete
Echo.
TIMEOUT /T 1 >NUL
exit