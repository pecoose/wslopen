#! /usr/bin/env bash

# https://github.com/cpbotha/xdg-open-ws

VERSION="0.0.1"
WIN_CMD="/mnt/c/Windows/System32/cmd.exe"
DISTRO=$(cat /etc/issue | awk '{printf $1}')

open_help() {
    echo "Open files and urls inside wsl[2]"
    echo "usage: open <file[s] | url[s]>"
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    open_help
    exit 0
elif [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
    echo "open version $VERSION"
    exit 0
elif [ "$#" -eq 0 ]; then
    open_help
    exit 1
fi

open_file() {
    local filepath=$(readlink -f $open_input)
    local win_filepath=${filepath//[\/]/\\\\\\\\}
    open_uri="\\\\\\\\wsl$\\\\\\\\$DISTRO"$win_filepath
}

open_url() {
    open_uri=$open_input
}

url_regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'

for filepath in "$@"; do
    if [[ $filepath =~ $url_regex ]]; then
        open_input=$filepath
        echo "open url $filepath"
        open_url
    elif [[ -f $filepath ]]; then
        open_input=$filepath
        echo "open file $filepath"
        open_file
    else
        echo "not a valid input: $filepath"
        continue
    fi
    eval "$WIN_CMD /c start \"$open_uri\" >/dev/null 2>/dev/null"
done

