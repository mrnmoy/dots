#!/usr/bin/bash

# while getopts ':t' arg; do 
#     case $arg in 
#         t)
#             echo "temporary"
#             ;;
#         h | *) 
#             echo "script usage: $(basename \$0) [-t]" >&2
#             exit 0
#             ;;
#     esac
# done

THEME_CONF="$HOME/.config/themes/colors-hyprland.conf"

if [[ $2 ]]; then  # temporary wallpaper 
    og_wal="$(sed -n '1p' $THEME_CONF | cut -d "=" -f2 | sed 's/^\s*\|\s*$//g')"
fi

hyprctl hyprpaper wallpaper ", $1, cover"

# if [[ $2 ]]; then  # generate colors from wallpaper
#     cwal -i $1 -o "$HOME/.config/themes"
# fi

if [[ $2 ]]; then
    sed -i 's/$wallpaper = .*/$wallpaper = '$og_wal'/' $THEME_CONF 
fi

