@echo off
@echo =====================================================================
@echo === 
@echo ===  install venv with requirments for py project in current dir 
@echo ===  use only py files and Internet
@echo === 
@echo === trust requirements.txt if it present or create new if not! 
@echo === 
@echo === use option -c to prepare for compile
@echo === 
@echo =====================================================================

if "%1"=="-c" ( @set COMPILE=yes &  @echo  prepare for compile mode ON )
if "%1"=="-C" ( @set COMPILE=yes &  @echo  prepare for compile mode ON )

if "%1"=="-h" ( pause && exit /b 0 )
if "%1"=="-H" ( pause && exit /b 0 )
if "%1"=="-?" ( pause && exit /b 0 )
if "%1"=="/?" ( pause && exit /b 0 )


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
@echo ### creating venv ...
%py% -m venv .	
@echo ### activating venv ...
call .\Scripts\activate.bat
@echo ### installing requirements  ...
pip install -r requirements.txt

@echo ### creating vstart  ...
@echo @rem execute script for use venv. call vstart.cmd ~pythonFile.py~ > vstart.cmd
@echo call .\Scripts\activate.bat >>vstart.cmd
@echo python.exe %%* >> vstart.cmd


REM ############################### TODO

if defined COMPILE (
    @echo off
    rem  for compile 
    pip install pyinstaller tinyaes

    echo call .\Scripts\activate.bat > compilew.cmd
    echo pyinstaller -F -w %1 >> compilew.cmd

    echo call .\Scripts\activate.bat > compile.cmd
    echo pyinstaller -F %1 >> compile.cmd


    echo call .\Scripts\activate.bat > compilewK.cmd
    echo pyinstaller -F -w --key KEY %1 >> compilewK.cmd

    echo call .\Scripts\activate.bat > compileK.cmd
    echo pyinstaller -F %1 --key KEY >> compileK.cmd


    echo compile venv created 
    echo 	use `compile.cmd <your file>`
    echo 	or `compilew.cmd <your file>` for no console
    echo 	or ...K.cmd  versions (modify KEY ! first) to encrypt
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