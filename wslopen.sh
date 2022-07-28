#! /usr/bin/env bash

# https://github.com/cpbotha/xdg-open-ws

VERSION="0.0.1"
WIN_CMD="/mnt/c/Windows/System32/cmd.exe"
DISTRO="$WSL_DISTRO_NAME"
PROG=wslopen
URL_REGEXP='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
VERBOSE_MODE=0
VALID_ARGS=$(getopt -o vbh --long version,verbose,'help' -- "$@")

function wslopen_help() {
    echo "wslopen: open files, directories and urls inside wsl/wsl2 using host apps"
    echo "    usage: $PROG [-v | --version] [-b | --verbose] [-h | --help] [file | directory | url]"
}

function wslopen_version() {
    echo "$PROG version $VERSION"
}

function wslopen_get_file_uri() {
    local filepath=$(readlink -f "$1")
    local win_filepath=${filepath//[\/]/\\\\\\\\}
    echo "\\\\\\\\wsl$\\\\\\\\$DISTRO"$win_filepath
}

function wslopen_get_dir_uri() {
    local filepath=$(readlink -f "$1")
    local win_filepath=${filepath//[\/]/\\\\}
    echo "\\\\\\\\wsl$\\\\$DISTRO"$win_filepath
}

function wslopen_get_url_uri() {
    echo "$1"
}

if [[ $? -ne 0 ]]; then
    echo "[ERROR] getopt returns error: $?"
    exit 1;
elif [[ $# -eq 0 ]]; then
    wslopen_help
    exit 1;
fi

eval set -- "$VALID_ARGS"
while [ : ]; do
    case "$1" in
        -v|--version)
            wslopen_version
            exit 1
            ;;
        -h|--help)
            wslopen_help
            exit 1
            ;;
        -b|--verbose)
            VERBOSE_MODE=1
            shift
            ;;
        *)
            WSLOPEN_INPUT="$2"
            shift;
            break
            ;;
    esac
done

if [[ $WSLOPEN_INPUT =~ $URL_REGEXP ]]; then
    [ $VERBOSE_MODE == 1 ] && echo "opened url $WSLOPEN_INPUT"
    wslopen_uri=$(wslopen_get_url_uri $WSLOPEN_INPUT)
elif [[ -f $WSLOPEN_INPUT ]]; then
    [ $VERBOSE_MODE == 1 ] && echo "opened file $WSLOPEN_INPUT"
    wslopen_uri=$(wslopen_get_file_uri $WSLOPEN_INPUT)
elif [[ -d $WSLOPEN_INPUT ]]; then
    [ $VERBOSE_MODE == 1 ] && echo "opened directory $WSLOPEN_INPUT"
    wslopen_uri=$(wslopen_get_dir_uri $WSLOPEN_INPUT)
else
    echo "[ERROR] not a valid input: $WSLOPEN_INPUT"
    exit 1
fi
eval "$WIN_CMD /c start \"\" \"$wslopen_uri\" >/dev/null 2>/dev/null"

