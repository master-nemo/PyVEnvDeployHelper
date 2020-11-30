# PyVEnvDeployHelper
small set of .bat scripts for deploy simple python scripts in venv to users windows PC with detect and use installed python interpreter

- it detect python interpreter from
  - PATH
  - py.exe launcher if it installed
  - registry if present python 3.7-3.9
  - trust existing `requirements.txt` or create new via [pigar](https://github.com/Damnever/pigar)
- option `-c` can be used to prepare venv to compile project using pyinstaller

## use:

`PyVEnvDeployHelper.bat -h` - for help

`PyVEnvDeployHelper.bat -c` - for compile version

```
=====================================================================
===
===  install venv with requirments for py project in current dir
===  use only py files and Internet
===
===  trust requirements.txt if it present or create new if not!
===
===  use option -c to prepare for compile
===
=====================================================================
```

## TODO:
 - autoinstall python intepreter if not installed

## WARNING
 - this script is provided AS IS without warranty, although all reasonable efforts was made to work it properly, but all possible damages is your responsiblity!
