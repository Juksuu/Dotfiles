#!/bin/bash

eval `amixer set Master "$1" unmute`

VOLUME=$(amixer -c 1 -M -D pulse get Master | grep -m 1 -o -E [[:digit:]]+%)
# echo "${VOLUME}"

DESCRIPTION=$(pactl list sinks | grep -A 2 "State: RUNNING" | sed '1,2d' | sed -e 's/^\s*//' -e '/^$/d')
# echo "${DESCRIPTION}"

eval `notify-send "$DESCRIPTION" "VOLUME: $VOLUME" -u low -h string:x-canonical-private-synchronous:volume`
