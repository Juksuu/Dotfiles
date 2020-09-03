#!/bin/bash
# Dmenu script for opening config files

declare options=("
bspwm
xmonad
awesome

emacs
neovim

xmobar

fish
dmenu
kitty
picom
sxhkd
xprofile

quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config: ')

case "$choice" in
    quit)
        echo "Program terminated." && exit 1
        ;;

    bspwm)
        choice="$HOME/.config/bspwm/bspwmrc"
        ;;
    xmonad)
        choice="$HOME/.xmonad/xmonad.hs"
        ;;
    awesome)
        choice="$HOME/.config/awesome/"
        ;;

    emacs)
        choice="$HOME/.emacs.d/"
        ;;
    neovim)
        choice="$HOME/.config/nvim/init.vim"
        ;;

    xmobar)
        choice="$HOME/.config/xmobar/"
        ;;

    fish)
        choice="$HOME/.config/fish/"
        ;;
    dmenu)
        choice="$HOME/.config/dmenu/edit-configs.sh"
        ;;
    kitty)
        choice="$HOME/.config/kitty/"
        ;;
    picom)
        choice="$HOME/.config/picom/picom.conf"
        ;;
    sxhkd)
        choice="$HOME/.config/sxhkd/sxhkdrc"
        ;;
    xprofile)
        choice="$HOME/.xprofile"
        ;;
    *)
        exit 1
        ;;
esac
kitty -e nvim "$choice"

