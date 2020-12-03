# PyVEnvDeployHelper
A small set of .bat scripts to deploy simple python scripts in venv to a user windows PC.
It detects and uses an installed python interpreter.

- it detects python interpreter from
  - PATH
  - py.exe launcher if it is installed
  - registry if python 3.7-3.9 is present (exprimental)
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

### TODO:
 - autoinstall python intepreter if not installed


##  "GETPIP+.BAT"

use it in dir with extracted `python-*-embed-*.zip' to install pip


 requires:
 *	.\==dir with extracted `python-*-embed-*.zip'
 *	..\curl\ (or edit line bellow to change place) contains curl
		
thanks for [tips](https://andreyv.ru/python-embedded-ili-kak-dobavit-python-v-svoe-prilozhenie.html)

##  "embedExtractAndPrepare.BAT"

extracted `python-*-embed-*.zip' and prepare pip via "GETPIP+.BAT"

 requires:
 *	.\==dir `python-*-embed-*.zip'
 *	.\curl\ (or edit line bellow to change place) contains curl
 *	"GETPIP+.BAT" in same dir
 *	7zip in PATH
		



## WARNING
 - this script is provided AS IS without warranty, although all reasonable efforts was made to work it properly, but all possible damages is your responsiblity!
