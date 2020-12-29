@ECHO 

if exist "C:\Program Files\IPConfigurator" (
	goto next
)	else (
	mkdir "C:\Program Files\IPConfigurator"
)
:next
if exist "C:\Program Files\IPConfigurator\read me.txt" (
	goto Files
)	else (
	goto downloads
) 

:downloads
ECHO.
ECHO Creating Files
powershell -command invoke-WebRequest "https://raw.githubusercontent.com/Exkli/TEST/main/test.txt" -Outfile "'C:\Program Files\IPConfigurator\readme.txt'"



:Start
ECHO Starting IP Configurator
ECHO.
ECHO.

:Files
SET /P download=Do you want to download the files again? (Y/N)

IF %download%=="Y" goto downloads
IF %download%=="N" goto end


:end

pause