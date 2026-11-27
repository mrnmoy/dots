#!/usr/bin/bash

THEME_CONF="$HOME/.config/themes/colors-hyprland.conf"

options=$(getopt -l "help,image:,mode:,colors,wallpaper,tmp" -o "hi:m:cwt" -a -- "$@")
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
            shift
            mode="$1"
            echo "theme_mode: $1"
            ;;
        -c|--colors)
            colors=1
            ;;
        -w|--wallpaper)
            wallpaper=1
            ;;
        -t|--temporary)
            temporary=1
            ;;
        --)
            shift
            break;;
    esac
    shift
done

genColors() {
    cwal -i $image -o "$HOME/.config/themes" -q
}

if [[ $wallpaper ]]; then
    echo "wallpaper: true"
    hyprctl hyprpaper wallpaper ", $image, cover"

    if [[ ! $colors ]]; then
    echo "colors: false"
        # sed -i 's/$wallpaper = .*/$wallpaper = '$image'/' $THEME_CONF 
        sed -i "s#\$wallpaper = .*#\$wallpaper = $image#" $THEME_CONF
    fi
fi

if [[ $colors ]]; then 
    echo "colors: true"
    if [[ $temporary ]]; then
        echo "temporary: true"
        og_wal="$(sed -n '1p' $THEME_CONF | cut -d "=" -f2 | sed 's/^\s*\|\s*$//g')"
        echo $og_wal
        genColors
        # sed -i 's/$wallpaper = .*/$wallpaper = '$og_wal'/' $THEME_CONF 
        sed -i "s#\$wallpaper = .*#\$wallpaper = $og_wal#" $THEME_CONF
    else
        genColors
    fi
fi
