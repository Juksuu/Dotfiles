#!/bin/bash
# Dmenu script for opening config files

declare options=("
bspwm
xmonad
awesome

emacs
neovim

xmobar
polybar

fish
alacritty
dmenu
picom
sxhkd
xprofile

quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config: ' -fn 'Code New Roman-10')

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
    polybar)
        choice="$HOME/.config/polybar/"
        ;;

    fish)
        choice="$HOME/.config/fish/"
        ;;
    alacritty)
        choice="$HOME/.config/alacritty/alacritty.yml"
        ;;
    dmenu)
        choice="$HOME/.config/dmenu/edit-configs.sh"
        ;;
    picom)
        choice="$HOME/.config/picom.conf"
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
alacritty -e nvim "$choice"

