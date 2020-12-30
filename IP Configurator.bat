@ECHO off
TITLE IP Configurator
::: Created By Sam Thomas
::: Version 1.1.1
::: https://github.com/Exkli/IPConfigurator

::: Admin Check
net session
if errorlevel 1 (
    goto Admin
) else ( goto Version
)
:version
::: Version Checker
if exist "C:\Program Files\IPConfigurator\Version Info.txt" (
    del "C:\Program Files\IPConfigurator\Version Info.txt"
)
Echo 1.1.1 >> "C:\Program Files\IPConfigurator\Version Info.txt" 
Ping www.google.nl -n 1 -w 1000
cls
if errorlevel 1 (
    GOTO ofd
)    else (
    GOTO Version
)
:Version
if exist "C:\temp\Version Info.txt" (
    del "C:\temp\Version Info.txt"
)
powershell -command invoke-WebRequest "https://raw.githubusercontent.com/Exkli/IPConfigurator/main/Version.txt" -Outfile "'C:\temp\Version Info.txt'" 

fc "C:\temp\Version Info.txt" "C:\Program Files\IPConfigurator\Version Info.txt"
if errorlevel 1 ( goto op
) else ( goto error
)
:error
ECHO Offline/Online Versions Do Not Match.
set /p update=Do you want to update?(Y/N)
if /i "%y%"=="y" GOTO updates
if /i "%n%"=="n" GOTO ofd
:updates
Timeout /T 1 > NUL
cls
call "autoupdate.bat"

::: IP Configurator
:ofd
cls
ECHO This Version may be out of date, Please connect your PC to the Internet to Update.
:OP
if exist "%USERPROFILE%\Desktop\IP Configurator - Shortcut.lnk" (
    goto OP1
) else copy "C:\Program Files\IPConfigurator\IP Configurator - Shortcut.lnk" "%USERPROFILE%\Desktop"
:OP1
ECHO Version 1.0.0
ECHO  ศอออออออออออออผ
ECHO  ศ	     Made By Sam 		   ผ
ECHO  ศอออออออออออออผ
ECHO.
ECHO.
:begin
if exist C:\temp (
	goto Temp
)	else (
	mkdir C:\temp
)
:Temp
if exist C:\temp\Interfaces.txt (
    del C:\temp\Interfaces.txt
	goto :new
)	else (
:new
for /F "tokens=4*" %%a in ('NETSH INT IP SHOW CONFIG ^| FINDSTR "Configuration for interface"') do @ECHO %%a %%b >>C:\temp\Interfaces.txt
	
)
set file=C:\Temp\Interfaces.txt
FOR /F "Tokens=*" %%L in (%file%) DO (
	set int1=%%L
	goto next
)
:next
set file=C:\Temp\Interfaces.txt
FOR /F "Skip=1 Tokens=*" %%k in (%file%) DO (
	set int2=%%k
    goto next1
) 
:next1
set file=C:\Temp\Interfaces.txt
FOR /F "Skip=2 Tokens=*" %%m in (%file%) DO (
	set int3=%%m
    goto Interfaces
)

:Interfaces
For /f %%E in ('Find "" /v /c ^< C:\temp\Interfaces.txt') Do Set lines=%%E
    IF "%Lines%"=="1" GOTO L1
    IF "%Lines%"=="2" GOTO L2
    IF "%Lines%"=="3" GOTO L3
    IF "%Lines%"=="4" GOTO L4
    IF "%Lines%"=="5" GOTO L5
    IF "%Lines%"=="6" GOTO L6

    :L1
        NETSH INT IP SHOW CONFIG | FINDSTR "Configuration for interface"
        ECHO.
        ECHO Choose Interface to Configure
        ECHO 1	
        ECHO.
        ECHO Type end to Quit
        GOTO START
    :L2
        NETSH INT IP SHOW CONFIG | FINDSTR "Configuration for interface"
        ECHO.
        ECHO Choose Interface to Configure
        ECHO 1	
        ECHO 2
        ECHO.
        ECHO Type end to Quit
        GOTO START
    :L3
        NETSH INT IP SHOW CONFIG | FINDSTR "Configuration for interface"
        ECHO.
        ECHO Choose Interface to Configure
        ECHO 1	
        ECHO 2
        ECHO 3
        ECHO.
        ECHO Type end to Quit
        GOTO START
    :L4
        NETSH INT IP SHOW CONFIG | FINDSTR "Configuration for interface"
        ECHO.
        ECHO Choose Interface to Configure
        ECHO 1	
        ECHO 2
        ECHO 3
        ECHO 4
        ECHO.
        ECHO Type end to Quit
        GOTO START
    :L5
        NETSH INT IP SHOW CONFIG | FINDSTR "Configuration for interface"
        ECHO.
        ECHO Choose Interface to Configure
        ECHO 1	
        ECHO 2
        ECHO 3
        ECHO 4
        ECHO 5
        ECHO.
        ECHO Type end to Quit
        GOTO START
    :L6
        NETSH INT IP SHOW CONFIG | FINDSTR "Configuration for interface"
        ECHO.
        ECHO Choose Interface to Configure
        ECHO 1	
        ECHO 2
        ECHO 3
        ECHO 4
        ECHO 5
        ECHO 6
        ECHO.
        ECHO Type end to Quit
        GOTO START

:START
SET /P NO= 
IF "%NO%"=="1" GOTO I1
IF "%NO%"=="2" GOTO I2
IF "%NO%"=="3" GOTO I3
IF "%NO%"=="end" GOTO END
IF "%NO%"=="time" GOTO time
IF "%NO%"=="999" GOTO colour

:I1
CLS
ECHO Interface; %int1%
ECHO.
ECHO Choose Option: 
ECHO 1 - View IP
ECHO 2 - Set Custom IP
ECHO 3 - Set IP to Dynamic VIA DHCP
ECHO.
ECHO Type end to Quit or start to return to the Start
SET /P NO=

IF "%NO%"=="1" GOTO IP1
IF "%NO%"=="2" GOTO IP2
IF "%NO%"=="3" GOTO IP3
IF "%NO%"=="end" GOTO END
IF "%NO%"=="start" GOTO begin
IF "%NO%"=="CLS" GOTO CLS

:IP1
netsh interface IPv4 show address %int1%
GOTO :I1

:IP2
SET /P address=Type address you wish to set as IP:
SET /P default=Type address you wish to set as Default Gateway:

netsh interface ip set address %int1% static %address% 255.255.255.0 %default%

ECHO Setting IP 
Timeout /T 1 > NUL
ECHO IP Set
GOTO :I1

:IP3
netsh interface ipv4 set address name=%int1% source=dhcp
ECHO Enabling DHCP
ECHO Changing IP
ECHO IP Set
GOTO :I1

:I2
CLS
ECHO Interface; %int2%
ECHO.
ECHO Choose Option: 
ECHO 1 - View IP
ECHO 2 - Set Custom IP
ECHO 3 - Set IP to Dynamic VIA DHCP
ECHO.
ECHO Type end to Quit or start to return to the Start
SET /P NO=

IF "%NO%"=="1" GOTO IP1.2
IF "%NO%"=="2" GOTO IP2.2
IF "%NO%"=="3" GOTO IP3.2
IF "%NO%"=="end" GOTO END
IF "%NO%"=="start" GOTO begin
IF "%NO%"=="CLS" GOTO CLS

:IP1.2
netsh interface IPv4 show address %int2%

GOTO :I2
:IP2.2
SET /P address=Type address you wish to set as IP:

netsh interface ip set address %int2% static %address% 255.255.255.0 192.168.0.1

ECHO Setting IP now
Timeout /T 1 > NUL
ECHO IP Set
GOTO :I2

:IP3.2
netsh interface ipv4 set address name=%int2% source=dhcp
ECHO Enabling DHCP
ECHO Changing IP
ECHO IP Set
GOTO :I2

:I3
CLS
ECHO Interface; %int3%
ECHO.
ECHO Choose Option: 
ECHO 1 - View IP
ECHO 2 - Set Custom IP
ECHO 3 - Set IP to Dynamic VIA DHCP
ECHO.
ECHO Type end to Quit or start to return to the Start
SET /P NO=

IF "%NO%"=="1" GOTO IP1.3
IF "%NO%"=="2" GOTO IP2.3
IF "%NO%"=="3" GOTO IP3.3
IF "%NO%"=="end" GOTO END
IF "%NO%"=="start" GOTO begin
IF "%NO%"=="CLS" GOTO CLS

:IP1.3
netsh interface IPv4 show address %int3%
GOTO :I3

:IP2.3
SET /P address=Type address you wish to set as IP:
SET /P default=Type address you wish to set as Default Gateway:

netsh interface ip set address %int3% static %address% 255.255.255.0 %default%

ECHO Setting IP 
Timeout /T 1 > NUL
ECHO IP Set
GOTO :I3

:IP3.3
netsh interface ipv4 set address name=%int3% source=dhcp
ECHO Enabling DHCP
ECHO Changing IP
ECHO IP Set
GOTO :I3

:Admin
cls
ECHO.
ECHO PLEASE RUN AS ADMINISTRATOR
PAUSE
goto end
:CLS
CLS
:END
ECHO Goodbye!
Timeout /T 1 > NUL
Exit
:time
setlocal
for /f "skip=8 tokens=2,3,4,5,6,7,8 delims=: " %%D in ('robocopy /l * \ \ /ns /nc /ndl /nfl /np /njh /XF * /XD *') do (
    set "dow=%%D"
    set "month=%%E"
    set "day=%%F"
    set "HH=%%G"
    set "MM=%%H"
    set "SS=%%I"
)

ECHO Year : %day%
ECHO Month : %month%
ECHO Day : %dow%
ECHO hour : %HH%
ECHO minutes : %MM%
ECHO seconds : %SS%
endlocal
:colour
ECHO 	Choose Colour
ECHO	0 = Black       8 = Gray
ECHO	1 = Blue        9 = Light Blue
ECHO	2 = Green       A = Light Green
ECHO	3 = Aqua        B = Light Aqua
ECHO	4 = Red         C = Light Red
ECHO	5 = Purple      D = Light Purple
ECHO	6 = Yellow      E = Light Yellow
ECHO	7 = White       F = Bright White
SET /P NO= 
IF "%NO%"=="0" GOTO Black
IF "%NO%"=="1" GOTO Blue
IF "%NO%"=="2" GOTO Green
IF "%NO%"=="3" GOTO Aqua
if "%no%"=="4" GOTO Red
IF "%NO%"=="5" GOTO Purple
IF "%NO%"=="6" GOTO Yellow
IF "%NO%"=="7" GOTO White
IF "%NO%"=="8" GOTO Gray
IF "%NO%"=="9" GOTO Light Blue
IF "%NO%"=="A" GOTO Light Green
IF "%NO%"=="B" GOTO Light Aqua
IF "%NO%"=="C" GOTO Light Red
IF "%NO%"=="D" GOTO Light Purple
IF "%NO%"=="E" GOTO Light Yellow
IF "%NO%"=="F" GOTO Bright White

:Black
color 0F
:Blue
color 10
:Green
color 20
:Aqua
color 30
:Purple
color 40
:Yellow
color 50
:Black
color 60
:White
color 70
:Gray
color 80
:Light Blue
color 90
:Light Green
color A0
:Light Aqua
color B0
:Light Red
color C0
:Light Purple
color D0
:Light Yellow
color E0
:Bright White
color F0
goto start


PAUSE
