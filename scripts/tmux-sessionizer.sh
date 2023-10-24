#!/bin/sh

base_folders=(~/code/personal/ ~/code/skynett/)
direct_folders=(~/.dotfiles/)

folder_list=$(find ${base_folders[@]} -mindepth 1 -maxdepth 1 -type d)
folder_list+=(${direct_folders[@]})

selected=$(printf "%s\n" "${folder_list[@]}" | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new -ds $selected_name -c $selected
fi


if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
else
    tmux switch -t $selected_name
fi
