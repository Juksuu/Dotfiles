#!/bin/bash

mkdir -p tmp/tslint
FILE="$(mktemp ./tmp/tslint/XXXXXXXX.ts)"

cat > "$FILE"

"$@" "$FILE"

rm -f ./tmp/tslint/*
