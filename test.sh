#! /usr/bin/env bash

WSL_OPEN=./wslopen.sh

# test basic input
$WSL_OPEN
$WSL_OPEN -h
$WSL_OPEN --help
$WSL_OPEN -v
$WSL_OPEN --version

tmp_d=$(mktemp -d)
html="$tmp_d/test.html"
cat >$html<<EOL
<!DOCTYPE html>
<html>

<head>
	<title>This is Hello World page</title>
</head>
<body>
 	<h1>Hello World</h1>
</body>
</html>
EOL

# test normal case
$WSL_OPEN $html
$WSL_OPEN https://github.com
$WSL_OPEN .
$WSL_OPEN $html https://github.com $html .

# test invalid case
$WSL_OPEN 123
