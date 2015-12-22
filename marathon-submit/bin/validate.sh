#!/bin/sh 
set -eux

for file in /submit/json/*.json; do
  jsonlint "$file"
done

# Prefer locally build lighter version
LIGHTER="/usr/bin/lighter"
DEVLIGHTER="/lighter/dist/lighter-$(uname -s)-$(uname -m)"
if [ -e  "$DEVLIGHTER" ]; then
    LIGHTER="$DEVLIGHTER"
fi

cd "/submit/site"
"$LIGHTER" verify $(find . -name \*.yml -not -name globals.yml)
