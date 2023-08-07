#!/bin/sh

dir="$HOME/.config/rofi"

rofi_command="rofi -theme ${dir}/themes/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
logout="󰍃"
lock=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$logout\n$lock"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
    $lock)
        # ~/.local/bin/lockscreen
        ;;
esac
