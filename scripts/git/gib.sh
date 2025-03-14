#!/bin/sh

git init --bare .bare
echo "gitdir: ./.bare" > .git

git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

branch=$(git branch --show-current)

# Add default branch as worktree
git worktree add $branch

# Set upstream correctly for the branch
cd $branch
git branch --set-upstream-to=origin/$branch
