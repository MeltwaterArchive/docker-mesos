#!/bin/sh -x

for file in $@; do
  while true; do
    curl -X POST -H "Content-Type: application/json" "${MARATHON_URL}/v2/apps?force=true" -d "@${file}"
    if [ "$?" == "0" ]; then
      break
    fi
    sleep 1
  done
done
