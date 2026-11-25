#!/usr/bin/bash

THEME_CONF="$HOME/.config/themes/colors-hyprland.conf"

if [[ $2 ]]; then  # temporary wallpaper 
    og_wal="$(sed -n '1p' $THEME_CONF | cut -d "=" -f2 | sed 's/^\s*\|\s*$//g')"
fi
cwal -i $1 -o "$HOME/.config/themes"
if [[ $2 ]]; then
    sed -i 's/$wallpaper = .*/$wallpaper = '$og_wal'/' $THEME_CONF 
fi
