#! /usr/bin/env bash

# test basic input
./index.sh
./index.sh -h
./index.sh --help
./index.sh -v
./index.sh --version

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
./index.sh $html
./index.sh https://github.com
./index.sh $html https://github.com $html

# test invalid case
./index.sh 123
