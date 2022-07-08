#! /usr/bin/env bash

# https://github.com/cpbotha/xdg-open-ws

VERSION="0.0.1"
WIN_CMD="/mnt/c/Windows/System32/cmd.exe"
DISTRO=$(cat /etc/issue | awk '{printf $1}')
PROG=wslopen
URL_REGEXP='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'

wslopen_help() {
    echo "wslopen: open files, directories and urls inside wsl/wsl2 using host apps"
    echo "    usage: $PROG [-v | --version] [-h | --help] [file] [directory] [url]"
}

wslopen_version() {
    echo "$PROG version $VERSION"
}

wslopen_get_file_uri() {
    local filepath=$(readlink -f $wslopen_input)
    local win_filepath=${filepath//[\/]/\\\\\\\\}
    wslopen_uri="\\\\\\\\wsl$\\\\\\\\$DISTRO"$win_filepath
}

wslopen_get_dir_uri() {
    local filepath=$(readlink -f $wslopen_input)
    local win_filepath=${filepath//[\/]/\\\\}
    wslopen_uri="\\\\\\\\wsl$\\\\$DISTRO"$win_filepath
}

wslopen_get_url_uri() {
    wslopen_uri=$wslopen_input
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    wslopen_help
    exit 0
elif [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
    wslopen_version
    exit 0
elif [ "$#" -eq 0 ]; then
    wslopen_help
    exit 1
fi

for filepath in "$@"; do
    if [[ $filepath =~ $URL_REGEXP ]]; then
        wslopen_input=$filepath
        echo "opened url $filepath"
        wslopen_get_url_uri 
    elif [[ -f $filepath ]]; then
        wslopen_input=$filepath
        echo "opened file $filepath"
        wslopen_get_file_uri
    elif [[ -d $filepath ]]; then
        wslopen_input=$filepath
        echo "opened directory $filepath"
        wslopen_get_dir_uri
    else
        echo "[ERROR] not a valid input: $filepath"
        continue
    fi
    eval "$WIN_CMD /c start \"$wslopen_uri\" >/dev/null 2>/dev/null"
done

