#!/usr/bin/env bash

paths=(
  "/org/gnome/desktop/wm/keybindings/"
  "/org/gnome/desktop/wm/preferences/"
  "/org/gnome/nautilus/preferences/"
  "/org/gnome/settings-daemon/plugins/media-keys/"
  "/org/gnome/shell/keybindings/"
  "/org/gnome/shell/extensions/dash-to-dock/"
  "/org/gnome/shell/extensions/gtile/"
)

dump () {
  for path in "${paths[@]}"; do
    filename=$(echo "$path" | sed 's/ //g') # remove whitespace
    filename=$(echo "$filename" | sed 's/^.//') # Remove first character
    filename=$(echo "$filename" | sed 's/.$//') # Remove last character
    filename=$(echo "$filename" | sed 's!/!-!g') # Substitute / with -
    filename="$HOME/.config/dotfiles/dconf/$filename"

    dconf dump $path > $filename
  done
}

load () {
  for path in "${paths[@]}"; do
    filename=$(echo "$path" | sed 's/ //g') # remove whitespace
    filename=$(echo "$filename" | sed 's/^.//') # Remove first character
    filename=$(echo "$filename" | sed 's/.$//') # Remove last character
    filename=$(echo "$filename" | sed 's!/!-!g') # Substitute / with -
    filename="$HOME/.config/dotfiles/dconf/$filename"

    dconf load $path < $filename
  done
}

if [ "$1" == "dump" ]; then
  dump
elif [ "$1" == "load" ]; then
  load
else
  echo "Usage: doit.sh store|dump"
fi



