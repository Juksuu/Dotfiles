#!/bin/sh

branches=()
while read -r path sha branch; do
    branches+=($path)
done <<< "$(git worktree list)"

selected=$(printf "%s\n" "${branches[@]}" | fzf)

if [[ -n $selected ]]; then
    cd $selected
fi
