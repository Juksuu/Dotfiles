#!/bin/sh

current_wallpaper_path=~/wallpapers/current
current_lockscreen_wallpaper_path=~/wallpapers/current_lockscreen
wallpaper_dir=~/wallpapers
thumbnail_dir=~/wallpapers/thumbnails

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
    hyprctl hyprpaper reload ,$current_wallpaper_path
    wal --backend colorthief -e -n -s -t -i "$1" > /dev/null 2>&1
  else
    echo "Invalid wallpaper path!"
  fi
}

set_current_lockscreen() {
  if [ -f $1 ]
  then
    echo "Updating current lockscreen wallpaper"
    echo $1

    if [ -f $current_lockscreen_wallpaper_path ]
    then
      rm $current_lockscreen_wallpaper_path
    fi

    ln -s $1 $current_lockscreen_wallpaper_path
  else
    echo "Invalid wallpaper path!"
  fi
}

generate_thumbnails() {
  if [ ! -d "$thumbnail_dir" ]; then
    mkdir -p $thumbnail_dir
  fi

  find $wallpaper_dir -maxdepth 1 -type f  | while read -r wallpaper; do
    thumbnail="$thumbnail_dir/$(basename $wallpaper)"

    if [ ! -f $thumbnail ]; then
      magick $wallpaper -resize 256x256 $thumbnail &
    fi
  done

  wait

  find $thumbnail_dir -maxdepth 1 -type f | while read -r thumbnail; do
    original="$wallpaper_dir/$(basename $thumbnail)"

    if [ ! -f $original ]; then
      rm $thumbnail
    fi
  done
}

get_wallpapers() {
  wallpaper_paths=()

  for path in $wallpaper_dir/*; do
    if [ -f $path ] && [ ! -L $path ]; then
      # path_converted=$(realpath --relative-to="${PWD}" "$path")
      wallpaper_paths+=("\"$path\"")
    fi
  done

  # Join the array elements with commas and print in the desired format
  echo "[${wallpaper_paths[@]}]" | sed 's/" "/", "/g'
}

get_thumbnails() {
  thumbnail_paths=()

  for path in $thumbnail_dir/*; do
    if [ -f $path ] && [ ! -L $path ]; then
      # path_converted=$(realpath --relative-to="${PWD}" "$path")
      thumbnail_paths+=("\"$path\"")
    fi
  done

  # Join the array elements with commas and print in the desired format
  echo "[${thumbnail_paths[@]}]" | sed 's/" "/", "/g'
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
