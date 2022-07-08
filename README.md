# wslopen: open files and urls using win10 browser inside wsl/wsl2

## Installation

```bash
make install
```

This program depends on variable `$BROWSER`, which refers to a win10 executable browser. You can put `BROWSER` variable in your `.bashrc`:

```bash
export BROWSER='/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
```

Tested on wsl2 ubuntu 20.04.

## Features

* [x] open html files
* [x] open urls
* [x] support ubuntu distro
* [ ] support other wsl2 distros

## Examples

```bash
open index.html
open https://github.com
open index.html https://github.com
open a.html b.html
```

