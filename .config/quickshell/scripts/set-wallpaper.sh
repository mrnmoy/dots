#!/usr/bin/bash

THEME_CONF="$HOME/.config/themes/colors-hyprland.conf"

hyprctl hyprpaper wallpaper ", $1, cover"

if ! [[ $2 ]]; then # tmp
    sed -i 's/$wallpaper = .*/$wallpaper = '$1'/' $THEME_CONF 
fi
