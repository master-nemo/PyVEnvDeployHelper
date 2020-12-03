echo off

REM ******************************************************************
REM extracted `python-*-embed-*.zip' and prepare pip via "GETPIP+.BAT"
REM ******************************************************************
REM **
REM ** requires:
REM **	.\==dir `python-*-embed-*.zip'
REM **	.\curl\ (or edit line bellow to change place) contains curl
REM **	"GETPIP+.BAT" in same dir
REM **	7zip in PATH
REM **		
REM ******************************************************************
REM automate tips from https://andreyv.ru/python-embedded-ili-kak-dobavit-python-v-svoe-prilozhenie.html

set builddir=build

if not exist %builddir% mkdir %builddir%

for /F %%z in ('where python-*embed-*.zip') do set zipname=%%z
echo =%zipname%=

set svnzexe=7z.exe
set curlexe=..\curl\curl.exe
REM uncomment following if curl in PATH in your system
REM set curlexe=curl.exe


%svnzexe%  x %zipname% -o%builddir%\
copy %~f0 %builddir%
copy "GETPIP+.BAT" %builddir%
cd %builddir%
call "GETPIP+.BAT"
goto :eof

