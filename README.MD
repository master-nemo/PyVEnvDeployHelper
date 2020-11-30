# PyVEnvDeployHelper
small set of .bat scripts for deploy simple python scripts in venv to users windows PC with detect and use installed python interpreter

- it detect python interpreter from
  - PATH
  - py.exe launcher if it installed
  - registry if present python 3.7-3.9
- trust existing `requirements.txt` or create new via [pigar](https://github.com/Damnever/pigar)
- options
  - `-h` or `-?` - get help
  - `-c` - prepare venv to compile project using pyinstaller
  - `-e` - not create vstart_* Scripts for each .py
  - `-w` - create noConsole vstart_* Scripts
- also you can modify this script for preset some options (see inside)

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
