#!/bin/sh

if [ ! $1 ] || [ ! $2 ]
then
    echo "Invalid parameters, wtc <folder> <repo>"
else
    # Create folder if it does not exist
    if [ ! -d $1 ]
    then
        mkdir $1
    fi
    cd $1

    # Clone repository as bare repo and set .git to point to right folder
    git clone --bare $2 .bare
    echo "gitdir: ./.bare" > .git

    # Set correct fetch data for git
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch

    # Get current default branch of repo
    branch=$(git branch --show-current)

    # Add default branch as worktree
    git worktree add $branch

    # Set upstream correctly for the branch
    cd $branch
    git branch --set-upstream-to=origin/$branch
fi
