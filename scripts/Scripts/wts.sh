#!/bin/bash

function get_correct_path() {
    local branch_name=""
    while read -r path sha branch; do
        if [ $branch ]
        then
            branch_name=$(sed 's/[][]//g' <<<"$branch")
        else
            branch_name=$(sed 's/[{()}]//g' <<<"$sha")
        fi

        if [ "$branch_name" == $1 ]
        then
            branch_path=$path
            return 1
        fi
    done <<< "$(git worktree list)"

    return 0
}

if [ "$1" == "" ]
then
    echo "Please provide a worktree to switch to, wts <worktree>"
else
    get_correct_path $1
    if [ $branch_path ]
    then
        cd $branch_path
    else
        echo "Worktree not found"
    fi
fi
