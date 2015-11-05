#!/bin/sh -eux

for file in $@; do
  jsonlint "$file"
done
