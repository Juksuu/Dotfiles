#!/bin/sh

current_wallpaper_path=~/wallpapers/current

load_current() {
  if [ -f $current_wallpaper_path ]
  then
    echo "Loading current wallpaper"
    hyprctl hyprpaper reload ,$current_wallpaper_path
    wal -e -n -s -t -i "$current_wallpaper_path" > /dev/null 2>&1
  else
    echo "No current wallpaper!"
  fi
}

set_current() {
  if [ -f $1 ]
  then
    echo "Updating current wallpaper"
    echo $1

    if [ -f $current_wallpaper_path ]
    then
      rm $current_wallpaper_path
    fi

    ln -s $1 $current_wallpaper_path
    load_current
  else
    echo "Invalid wallpaper path!"
  fi
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
