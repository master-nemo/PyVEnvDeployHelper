# PyVEnvDeployHelper
A small set of .bat scripts to deploy simple python scripts in venv to a user windows PC. 
It detects and uses an installed python interpreter.

- it detects python interpreter from
  - PATH
  - py.exe launcher if it is installed
  - registry if python 3.7-3.9 is present
- trusts existing `requirements.txt` or creates new via [pigar](https://github.com/Damnever/pigar)
- options
  - `-h` or `-?` - get help
  - `-c` - prepare venv to compile project using pyinstaller
  - `-e` - not create vstart_* Scripts for each .py
  - `-w` - create noConsole vstart_* Scripts
- also you can modify this script to preset some options (see inside)

## use:

`PyVEnvDeployHelper.bat [options]` 

```
=====================================================================
===
===  install venv with requirments for py project in current dir
===  use only py files and Internet
===
===  trust requirements.txt if it present or create new if not!
===
=== options:
===                     -h or -?        -       help
===                     -c              -       prepare for compile
===                     -e              -       not create vstart_* Scripts for each .py
===                     -w              -       create noConsole vstart_* Scripts
===
=== also you can modify this script for preset options (see inside)
===
=====================================================================
```

## TODO:
 - autoinstall python intepreter if not installed

## WARNING
 - this script is provided AS IS without warranty, although all reasonable efforts was made to work it properly, but all possible damages is your responsiblity!
