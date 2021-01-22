#!/bin/bash

if [ $1 ]; then
    teamocilList=$(teamocil --list)

    for val in $teamocilList; do
        if [ $val == $1 ]; then
            exec tmux new-session -d "teamocil $1" \; attach
        fi
    done
fi
