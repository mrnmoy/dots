#!/usr/bin/bash

THEME_CONF="$HOME/.config/themes/colors-hyprland.conf"

options=$(getopt -l "help,image:,mode:,colors,wallpaper,tmp" -o "hi:m:cw:t" -a -- "$@")
eval set -- "$options"

while true; do
    case "$1" in
        -h|--help) 
            echo "Usage: "
            exit 0
            ;;
        -i|--image) 
            shift
            image="$1"
            echo "image: $1"
            ;;
        -m|--mode)
            mode="$1"
            echo "theme_mode: $1"
            ;;
        -c|--colors)
            colors=1
            echo "dynamicColors: true"
            ;;
        -w|--wallpaper)
            wallpaper=1
            echo "dynamicWallpaper: true"
            ;;
        -t|--temporary)
            temporary=1
            echo "temporaryWallpaper: true"
            ;;
        --)
            shift
            break;;
    esac
    shift
done

genColors() {
    cwal -i $1 -o "$HOME/.config/themes"
}

if [[ $wallpaper ]]; then
    hyprctl hyprpaper wallpaper ", $1, cover"

    if ! [[ $colors ]]; then
        sed -i 's/$wallpaper = .*/$wallpaper = '$image'/' $THEME_CONF 
    fi
fi

if [[ $colors ]]; then 
    if [[ $temporary ]]; then
        og_wal="$(sed -n '1p' $THEME_CONF | cut -d "=" -f2 | sed 's/^\s*\|\s*$//g')"
        genColors()
        sed -i 's/$wallpaper = .*/$wallpaper = '$og_wal'/' $THEME_CONF 
    else
        genColors()
    fi
fi
