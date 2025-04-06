#!/bin/sh

get_monitor_plug_name() {
    echo $(hyprctl activeworkspace -j | jq -r '.monitor')
}

right() {
    ags toggle rightpanel_$(get_monitor_plug_name)
}

settings() {
    ags toggle settings_$(get_monitor_plug_name)
}

wallpapers() {
    ags toggle wallpaper_switcher_$(get_monitor_plug_name)
}

if [ ! -z "$1" ]
then
  # Check if the function exists (bash specific)
  if declare -f "$1" > /dev/null
  then
    # call arguments verbatim
    "$@"
  else
    # Show a helpful error
    echo "'$1' is not a known function name" >&2
    exit 1
  fi
fi
