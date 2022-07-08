#! /usr/bin/env bash

# edge file:\\wsl$\\Ubuntu\\home\\rbamb\\tutorial\\webpack\\guide\\dist\\index.html

VERSION="0.0.1"

if [[ -z "${BROWSER}" ]]; then
    echo 'variable $BROWSER not set.'
    exit 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "usage: browser <file[s] | url[s]>"
    exit 0
elif [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
    echo "browser version $VERSION"
    exit 0
elif [ "$#" -eq 0 ]; then
    echo "usage: browser <file[s] | url[s]>"
    exit 1
fi

open_file() {
    local filepath=$(readlink -f $open_input)
    local res=${filepath//[\/]/\\\\}
    open_uri="file:\\\\wsl$\\\\Ubuntu\\"$res
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
    "$BROWSER" $open_uri
done

