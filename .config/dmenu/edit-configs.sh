#!/bin/bash
# Dmenu script for opening config files

declare options=("
awesome
emacs
fish
kitty
neovim
picom
sxhkd
xmobar
xmonad
xprofile
quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	awesome)
		choice="$HOME/.config/awesome/"
	;;
	emacs)
		choice="$HOME/.emacs.d/"
	;;
    fish)
		choice="$HOME/.config/fish/"
	;;
	kitty)
		choice="$HOME/.config/kitty/kitty.conf"
	;;
	neovim)
		choice="$HOME/.config/nvim/init.vim"
	;;
	picom)
		choice="$HOME/.config/picom/picom.conf"
	;;
	sxhkd)
		choice="$HOME/.config/sxhkd/sxhkdrc"
	;;
	xmobar)
		choice="$HOME/.config/xmobar/"
	;;
	xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	xprofile)
		choice="$HOME/.xprofile"
	;;
	*)
		exit 1
	;;
esac
kitty -e nvim "$choice"

