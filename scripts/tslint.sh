#!/bin/bash

mkdir -p tmp
FILE="$(mktemp ./tmp/XXXXXXXX.ts)"

cat > "$FILE"

"$@" "$FILE"

rm -f ./tmp/*
