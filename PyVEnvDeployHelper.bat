@echo off
@echo =====================================================================
@echo === 
@echo ===  install venv with requirments for py project in current dir 
@echo ===  use only py files and Internet
@echo === 
@echo === trust requirements.txt if it present or create new if not! 
@echo === 
@echo === options:
@echo ===			-h or -?	- 	help
@echo ===			-c		- 	prepare for compile
@echo ===			-e		- 	not create vstart_* Scripts for each .py
@echo ===			-w		- 	create noConsole vstart_* Scripts
@REM @echo ===			-m 			- 	minimal venv only without requirements 
@REM @echo === 							for distrib minimal and deploy at users PC 
@REM @echo === 			-f			- 	force create env even if it already exist				
@echo === 
@echo === also you can modify this script for preset options (see inside)
@echo === 
@echo =====================================================================

@REM also you can modify this script for preset options:
@REM uncomment following for:

@REM @rem		create noConsole vstart_* Scripts:
@REM @set PYvstart=start pythonw.exe

@REM @rem		prepare for compile
@REM @set COMPILE=yes

@REM @REM @rem		not create vstart_* Scripts for each .py
@REM @set NOVSTARTS=yes
@echo =====================================================================


@REM #################################################################################

@REM default
@set PYvstart=python.exe


:loopParam
set AA=%1
if defined AA (
    if "%AA%"=="-h" ( pause && exit /b 0 )
    if "%AA%"=="-H" ( pause && exit /b 0 )
    if "%AA%"=="-?" ( pause && exit /b 0 )
    if "%AA%"=="/?" ( pause && exit /b 0 )

    if "%AA%"=="-c" ( @set COMPILE=yes &  @echo  prepare for compile mode ON )
    if "%AA%"=="-C" ( @set COMPILE=yes &  @echo  prepare for compile mode ON )
    
	if "%AA%"=="-e" ( @set NOVSTARTS=yes &  @echo  prepare for compile mode ON )
    if "%AA%"=="-E" ( @set NOVSTARTS=yes &  @echo  prepare for compile mode ON )
    
	if "%AA%"=="-w" ( @set PYvstart=start pythonw.exe &  @echo  prepare for compile mode ON )
    if "%AA%"=="-W" ( @set PYvstart=start pythonw.exe &  @echo  prepare for compile mode ON )

    shift
    goto :loopParam
    ) 


@REM ========Detect Python interpretator in system ===================
@echo ==== Detect Python interpretator in system ====
@REM setlocal enabledelayedexpansion
@call :detectPyexe
@echo py interpretator found `%PYEXEDETECTED%`
@REM endlocal   @echo -=%PYEXEDETECTED%=-

if not defined PYEXEDETECTED (
    @echo no Python interpretator found :(
    @pause
    @xit /B 1
    )

@set py=%PYEXEDETECTED%
@echo ==== Detected python = `%py%` ====

@REM ########### now %py% points to actual Python.exe ################

if exist requirements.txt (
    echo `requirements.txt` exist. use it
    ) else (
    @rem use pigar https://github.com/Damnever/pigar
    @rem alt https://github.com/bndr/pipreqs		@rem pipreqs .

    where pigar
    if errorlevel 1 (
        echo no pigar found trying to install
        %py% -m pip install pigar
        )

    %py% -m pigar 
    )


@REM ### create venv ##############

if exist Scripts ( 
	echo venv already exist.

	@REM TODO

	) else (
	@echo ### creating venv ...
	%py% -m venv .	
	) 


@echo ### activating venv ...
call .\Scripts\activate.bat
@echo ### installing requirements  ...
pip install -r requirements.txt

:vstart
@echo off

echo ### creating universal vstart that activates venv and start specified script ...
echo @rem execute script for use venv. call vstart.cmd ~pythonFile.py~ > vstart.cmd
echo call .\Scripts\activate.bat >>vstart.cmd
echo %PYvstart% %%* >> vstart.cmd

if not defined NOVSTARTS (
	echo ### creating vstart for all py ...
	for %%q in (*.py) do echo call .\Scripts\activate.bat ^& %PYvstart% %%q %%* > vstart_%%q.cmd
	)

@REM for %%p in (*.py) do 


if defined COMPILE (
    echo pfepare venv for compile 
    pip install pyinstaller tinyaes

    echo call .\Scripts\activate.bat > compilew.cmd
    echo pyinstaller -F -w  %%* >> compilew.cmd

    echo call .\Scripts\activate.bat > compile.cmd
    echo pyinstaller -F  %%* >> compile.cmd


    echo call .\Scripts\activate.bat > compilewK.cmd
    echo pyinstaller -F -w --key KEY  %%* >> compilewK.cmd

    echo call .\Scripts\activate.bat > compileK.cmd
    echo pyinstaller -F  %%* --key KEY >> compileK.cmd


    echo compile venv created 
    echo 	use `compile.cmd <your file>`
    echo 	or `compilew.cmd <your file>` for no console
    echo 	or ...K.cmd  versions to encrypt. modify KEY first !!!
    )


pause 
goto :eof
@REM ########################################################
@REM ########################################################


@REM ######## :detectPyexe inlined ############
:detectPyexe

@echo off

where python.exe
if errorlevel 1 (
	echo no python in path. good
	) else (
	echo use nearest python 
	set PYEXEDETECTED=python.exe
	echo PYEXEDETECTED=%PYEXEDETECTED%
	goto :eof
	)

where py.exe
if errorlevel 1 (
	echo no python in path. good
	) else (
	echo use python launcher
	set PYEXEDETECTED=py.exe
	echo PYEXEDETECTED=%PYEXEDETECTED%
	goto :eof
	)
	
	
REM search in reg	REM HKEY_LOCAL_MACHINE\SOFTWARE\Python\PythonCore\3.8\InstallPath
rem	VERSIONS of PYTHON 3.%%a (start,step,end)!!!
for /L %%a in (9,-1,7) do (
	echo check for 3.%%a
	reg QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Python\PythonCore\3.%%a\InstallPath /v ExecutablePath
	if errorlevel 1 (
		echo no python 3.%%a
		) else (
		echo found python 3.%%a

		for /f "tokens=* usebackq delims=	" %%i in (`reg QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Python\PythonCore\3.8\InstallPath /v ExecutablePath`) do echo TMPdetect1=%%i
		for /f "usebackq tokens=3" %%x in ('%detect%') do set TMPdetect2=%%x
		echo ~%TMPdetect2%~
		
		if defined TMPdetect2 (
			echo use python 3.%%a
			set PYEXEDETECTED=%TMPdetect2%
			echo PYEXEDETECTED=%PYEXEDETECTED%
			goto :eof
			) else (
			echo no TMPdetect2
			)
		)
	)

@REM not found py
goto :eof   
@REM =================== end of sub


@REM :subvstartW
@REM set PYsubvstart=pythonw.exe

@REM :subvstart
@REM if not defined PYsubvstart set PYsubvstar=python.exe

@REM 	setlocal
@REM 	set P1=%1
@REM 	if not defined P1 echo @rem for start py using venv call vstart_.cmd ~pythonFile.py~ > vstart_.cmd
@REM 	endlocal

@REM 	echo call .\Scripts\activate.bat ^& %PYsubvstart% %%1 %%*  >> vstart_%1.cmd


@REM goto :eof   
@REM @REM =================== end of sub










