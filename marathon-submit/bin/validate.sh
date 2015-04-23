#!/bin/bash -eux

for file in $@; do
  jsonlint "$file"
done
