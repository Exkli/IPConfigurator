@ECHO OFF
TITLE IP Updater
::: Created By Sam Thomas
::: Updater
::: Version 1.0.0
::: https://github.com/Exkli/IPConfigurator

::: Admin Check
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

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
) else ( goto op
)

::: Updater
:op
ECHO  ศอออออออออออออผ
ECHO  ศ	     Made By Sam 		   ผ
ECHO  ศอออออออออออออผ
ECHO.
ECHO Deleting File - Version Info.txt
ECHO Deleting File - readme.txt
ECHO Deleting File - IP Configurator
del "C:\Program Files\IPConfigurator\Version Info.txt"
del "C:\Program Files\IPConfigurator\readme.txt"
del "C:\Program Files\IPConfigurator\IP Configurator.bat"

ECHO Downloading File - IP Configurator
powershell -command invoke-WebRequest "'https://raw.githubusercontent.com/Exkli/IPConfigurator/main/IP Configurator.bat'" -Outfile "'C:\Program Files\IPConfigurator\IP Configurator.bat'"
ECHO Downloading File - readme.txt
powershell -command invoke-WebRequest "https://raw.githubusercontent.com/Exkli/IPConfigurator/main/README.md" -Outfile "'C:\Program Files\IPConfigurator\readme.txt'"

Timeout /t 2 >NUL
cls
ECHO Running IP Configurator
call "C:\Program Files\IPConfigurator\IP Configurator.bat"

:Admin
cls
ECHO.
ECHO PLEASE RUN AS ADMINISTRATOR
PAUSE
Exit