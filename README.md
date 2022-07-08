# wslopen: open files, directories and urls using win10 applications inside wsl/wsl2

## Installation

```bash
sudo make install
```

This program depends on windows execuable `cmd.exe`, which shoule be basically at any windows machine. 

Tested on wsl2 ubuntu 20.04.

## Features

* [x] open files
* [x] open urls
* [x] open directories
* [x] support ubuntu distro
* [x] support other wsl/wsl2 distros

## Examples

```bash
wslopen index.html
wslopen https://github.com
wslopen index.html https://github.com
wslopen a.html b.html
```

