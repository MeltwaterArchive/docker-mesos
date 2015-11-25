#!/bin/sh -x

for file in $@; do
  while true; do
    curl -X POST -H "Content-Type: application/json" "${CHRONOS_URL}/scheduler/iso8601" -d "@${file}"
    if [ "$?" == "0" ]; then
      break
    fi
    sleep 1 & wait
  done
done

while true; do
  sleep 10000 & wait
done
