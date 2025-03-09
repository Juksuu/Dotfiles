#!/bin/sh

rofiStyle="${ROFI_STYLE:-1}"

if [[ "${rofiStyle}" =~ ^[0-9]+$ ]]; then
    rofi_config="~/.config/rofi/themes/style_${rofiStyle}"
else
    rofi_config="~/.config/rofi/themes/${rofiStyle:-"style_1"}"
fi

rofi_config="${ROFI_LAUNCH_STYLE:-$rofi_config}"

case "${1}" in
d | --drun)
    r_mode="drun"
    rofi_config="${ROFI_LAUNCH_DRUN_STYLE:-$rofi_config}"
    ;;
r | --run)
    r_mode="run"
    rofi_config="${ROFI_LAUNCH_RUN_STYLE:-$rofi_config}"
    ;;
h | --help)
    echo -e "$(basename "${0}") [action]"
    echo "d :  drun mode"
    echo "r :  run mode"
    exit 0
    ;;
*)
    r_mode="drun"
    ROFI_LAUNCH_DRUN_STYLE="${ROFI_LAUNCH_DRUN_STYLE:-$ROFI_LAUNCH_STYLE}"
    rofi_config="${ROFI_LAUNCH_DRUN_STYLE:-$rofi_config}"
    ;;
esac

rofi -show "${r_mode}" \
    -show-icons \
    -theme "${rofi_config}" &
