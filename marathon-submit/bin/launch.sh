#!/bin/sh -x

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
    /bin/lighter -v deploy -f -m "${MARATHON_URL}" $(find /submit/site -name \*.yml -not -name globals.yml)
}

DEPLOY;
EVENTS="CREATE,CLOSE_WRITE,DELETE,MODIFY,MOVED_FROM,MOVED_TO"

inotifywait -m -q -e "$EVENTS" -r --format '%:e %w%f' "/submit/site" | while read file
  do
    DEPLOY;
  done
