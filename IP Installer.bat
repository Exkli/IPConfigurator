@ECHO off
TITLE IP Installer
::: Created By Sam Thomas
::: Installer
::: Version 1.1.0
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

::: Installer
:op
cls
ECHO  ศอออออออออออออผ
ECHO  ศ	     Made By Sam 		   ผ
ECHO  ศอออออออออออออผ
ECHO.
ECHO RUN AS ADMINISTRATOR
ECHO.
ECHO 1 - Start Installer
ECHO 2 - Start IP Configurator
SET /P no=
if "%no%"=="2" GOTO end
if "%no%"=="1" GOTO begin
ECHO.
ECHO.
:begin
set /a x=0
if exist "C:\Program Files\IPConfigurator" (
	goto next
)	else (
	mkdir "C:\Program Files\IPConfigurator"
)
:next
if exist "C:\Program Files\IPConfigurator\readme.txt" (
	goto downloads
)	else (
	goto downloads
) 
:Count
set /a x=1
GOTO downloads
:downloads
ECHO.
ECHO Creating Files
powershell -command invoke-WebRequest "'https://raw.githubusercontent.com/Exkli/IPConfigurator/main/IP Configurator.bat'" -Outfile "'C:\Program Files\IPConfigurator\IP Configurator.bat'"
powershell -command invoke-WebRequest "https://raw.githubusercontent.com/Exkli/IPConfigurator/main/autoupdater.bat" -Outfile "'C:\Program Files\IPConfigurator\autoupdater.bat'"
powershell -command invoke-WebRequest "https://raw.githubusercontent.com/Exkli/IPConfigurator/main/README.md" -Outfile "'C:\Program Files\IPConfigurator\readme.txt'"
powershell -command invoke-WebRequest "'https://raw.githubusercontent.com/Exkli/IPConfigurator/main/IP Installer.bat'" -Outfile "'C:\Program Files\IPConfigurator\IP Installer.bat'"
powershell -command invoke-WebRequest "'https://github.com/Exkli/IPConfigurator/raw/main/IP Configurator - Shortcut.lnk'" -Outfile "'C:\Program Files\IPConfigurator\IP Configurator - Shortcut.lnk'"
powershell -command invoke-WebRequest "'https://raw.githubusercontent.com/Exkli/IPConfigurator/main/uninstall.bat'" -Outfile "'C:\Program Files\IPConfigurator\uninstall.bat'"
GOTO end
:::	if "%x%"=="0" GOTO Files
:::	if "%x%"=="1" GOTO end


:::	:Files
:::	SET /P download=Do you want to download the files again? (Y/N)
:::	IF /i "%download%"=="Y" goto Count
:::	IF /i "%download%"=="N" goto end
:::
:Admin
cls
ECHO.
ECHO PLEASE RUN AS ADMINISTRATOR
PAUSE
exit
:IP
cls
goto end
:end
ECHO Starting IP Configurator
ECHO.
ECHO.
ECHO Goodbye
Timeout /T 1 > NUL
cls
Timeout /T 1 > NUL
call "C:\Program Files\IPConfigurator\IP Configurator.bat"

