#!/bin/bash

for dir in */; do
    stow -R "$dir"
done
