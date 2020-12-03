@echo off

REM ******************************************************************
REM use it in dir with extracted `python-*-embed-*.zip' to install pip
REM ******************************************************************
REM **
REM ** requires:
REM **	.\==dir with extracted `python-*-embed-*.zip' 
REM **	..\curl\ (or edit line bellow to change place) contains curl
REM **		
REM ******************************************************************


set curlexe=..\curl\curl.exe
REM uncomment following if curl in PATH in your system
REM set curlexe=curl.exe

REM automate tips from https://andreyv.ru/python-embedded-ili-kak-dobavit-python-v-svoe-prilozhenie.html

REM add like uncomment))

findstr /B "import site" python38._pth
if errorlevel 1 (
	@echo adding `import site`
	@echo import site>> python38._pth
	) else (	@echo `import site` already in	)


REM get and install curl
%curlexe% https://bootstrap.pypa.io/get-pip.py -o get-pip.py
pause
python get-pip.py

pause




