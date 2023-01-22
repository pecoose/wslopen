#! /usr/bin/env bash

VERSION="0.0.2"
PROG="wslopen"
WIN_CMD="/mnt/c/Windows/System32/cmd.exe"
DISTRO=$WSL_DISTRO_NAME

wslopen_version() {
  echo "$PROG version $VERSION"
}

wslopen_help() {
  echo "wslopen: open files, directories and urls inside wsl/wsl2 using host apps"
  echo "    usage: $PROG [-v | -V | --version] [-h | --help] [file] [directory] [url]"
}

wslfile2win() {
  local wslpath="$1"
  local abswslpath=$(readlink -f "$wslpath")
  local winpath=${abswslpath//[\/]/\\\\\\\\}
  winpath="\\\\\\\\wsl$\\\\\\\\$DISTRO"$winpath""
  echo "$winpath"
}

wsldir2win() {
  local wslpath="$1"
  local abswslpath=$(readlink -f "$wslpath")
  local winpath=${abswslpath//[\/]/\\\\}
  winpath="\\\\\\\\wsl$\\\\$DISTRO"$winpath""
  echo "$winpath"
}

wslopen_https_proto() {
  echo "$1"
}

wslopen_file_proto() {
  local fileurl="$1"
  local filepath="$(echo "$fileurl" | cut -c8-)"
  echo $(wslfile2win "$filepath")
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  wslopen_help
  exit 0
elif [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
  wslopen_version
  exit 0
elif [ "$#" -eq 0 ]; then
  wslopen_help
  exit 0
fi

for something in "$@"; do
  if [[ "$something" == http://* ]] || [[ "$something" == https://* ]]; then
    target=$(wslopen_https_proto "$something")
  elif [[ "$something" == file://* ]]; then
    target=$(wslopen_file_proto "$something")
  elif [[ -f "$something" ]]; then
    target=$(wslfile2win "$something")
  elif [[ -d "$something" ]] || [[ "$something" == \.+ ]]; then
    target=$(wsldir2win "$something")
  else
    echo "not a valid input: $something"
    continue
  fi
  eval "$WIN_CMD /c start \"\" \"$target\" >/dev/null 2>/dev/null"
done

