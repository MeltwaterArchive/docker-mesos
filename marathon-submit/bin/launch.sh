#!/bin/sh
set -x

# Prefer locally build lighter version
LIGHTER="/usr/bin/lighter"
DEVLIGHTER="/lighter/dist/lighter-$(uname -s)-$(uname -m)"
if [ -e  "$DEVLIGHTER" ]; then
    LIGHTER="$DEVLIGHTER"
fi

for file in /submit/json/*.json; do
  while true; do
    curl -X POST -H "Content-Type: application/json" "${MARATHON_URL}/v2/apps?force=true" -d "@${file}"
    if [ "$?" == "0" ]; then
      break
    fi
    sleep 1 & wait
  done
done

# Run lighter to deploy yaml files
function DEPLOY {
    mkdir -p /submit/target
    chmod -R a+rwX /submit/site/keys
    cd /submit/site

    "$LIGHTER" -t /submit/target deploy -f -m "${MARATHON_URL}" $(find . -name \*.yml -not -name globals.yml)
    chmod -R a+rwX /submit/target
}

DEPLOY;
EVENTS="CREATE,CLOSE_WRITE,DELETE,MODIFY,MOVED_FROM,MOVED_TO"

inotifywait -m -q -e "$EVENTS" -r --format '%:e %w%f' "/submit/site" "$LIGHTER" | while read file
  do
    DEPLOY;
  done
