# wslbrowser: open files and urls using win10 browser inside wsl/wsl2

## installation

```bash
make install
```

this tools depends on variable `$BROWSER`, which refers to a win10 browser link. You can put BROWSER variable in your `.bashrc`:

```bash
export BROWSER='/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
```

## examples

```bash
open index.html
open https://github.com
open index.html https://github.com
open a.html b.html
```
