#!/bin/bash

# $1 = wallpaper path

if [ "$#" -eq 0 ]; then
    echo "image is required"
    exit 1
fi

themes=$HOME/.config/themes
wallpaper=$themes/background."${1##*.}"
cp $1 $wallpaper

# Set wallpaper
hyprctl hyprpaper reload ,$wallpaper

# Set colors
readarray -t colors <<< $(palgen -i $wallpaper -c 16)
colors=($(printf "%s\n" "${colors[@]}" | sort -r -t'#' -k2,2))

primary=${colors[3]}
secondary=${colors[4]}
tertiary=${colors[5]}
surface='#00000001'
onPrimary=${colors[0]}
onSecondary=${colors[0]}
onTertiary=${colors[0]}
onSurface=${colors[0]}

# highlight='hsla(0, 0%, 100%, 0.08)'
highlight='#ffffff14'
radius='16px'
shadow="0px 0px 8px 4px $primary"
transition='all 50ms cubic-bezier(0.85, 0, 0.15, 1)'

hex_to_rgb() {
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))

    if (( ${#_} == 8 )); then
        ((a=16#${_:6:2}))
        a=$(printf "%.3f" "$(bc -l <<< "$a/255")")
        echo "rgba($r, $g, $b, $a)"
    else
        echo "rgb($r, $g, $b)"
    fi
}

# Raw colors
echo "wallpaper=$wallpaper

primary=$primary
secondary=$secondary
tertiary=$tertiary
surface=$surface
onPrimary=$onPrimary
onSecondary=$onSecondary
onTertiary=$onTertiary
onSurface=$onSurface

highlight=$highlight
radius=$radius
shadow=$shadow
transition=$transition" > $themes/colors

# Fish colors
echo "set wallpaper $wallpaper

set primary $primary
set secondary $secondary
set tertiary $tertiary
set surface $surface
set onPrimary $onPrimary
set onSecondary $onSecondary
set onTertiary $onTertiary
set onSurface $onSurface

set highlight $highlight
set radius $radius
set shadow $shadow
set transition $transition" > $themes/colors.fish

# Css colors
echo ":root {
    --wallpaper: url('$wallpaper');

    --primary: $primary;
    --secondary: $secondary;
    --tertiary: $tertiary;
    --surface: $surface;
    --onPrimary: $onPrimary;
    --onSecondary: $onSecondary;
    --onTertiary: $onTertiary;
    --onSurface: $onSurface;

    --highlight: $highlight;
    --radius: $radius;
    --shadow: $shadow;
    --transition: $transition;
}" > $themes/colors.css

# Gtk colors
echo "
@define-color primary $primary;
@define-color secondary $secondary;
@define-color tertiary $tertiary;
@define-color surface $(hex_to_rgb $surface);
@define-color onPrimary $onPrimary;
@define-color onSecondary $onSecondary;
@define-color onTertiary $onTertiary;
@define-color onSurface $onSurface;

@define-color highlight $(hex_to_rgb $highlight);" > $themes/colors-gtk.css

# Rasi colors
echo "* {
    wallpaper: url('$wallpaper');

    primary: $primary;
    secondary: $secondary;
    tertiary: $tertiary;
    surface: $surface;
    onPrimary: $onPrimary;
    onSecondary: $onSecondary;
    onTertiary: $onTertiary;
    onSurface: $onSurface;

    highlight: $highlight;
    radius: $radius;
}" > $themes/colors.rasi
# shadow: $shadow;
# transition: $transition;

# Conf colors
echo "\$wallpaper = $wallpaper

\$primary = $(hex_to_rgb $primary)
\$secondary = $(hex_to_rgb $secondary)
\$tertiary = $(hex_to_rgb $tertiary)
\$surface = $(hex_to_rgb $surface)
\$onPrimary = $(hex_to_rgb $onPrimary)
\$onSecondary = $(hex_to_rgb $onSecondary)
\$onTertiary = $(hex_to_rgb $onTertiary)
\$onSurface = $(hex_to_rgb $onSurface)

\$highlight = $(hex_to_rgb $highlight)
\$radius = $radius
\$shadow = $shadow
\$transition = $transition" > $themes/colors.conf

# Lua colors
echo "return {
    wallpaper = '$wallpaper',

    primary = '$primary',
    secondary = '$secondary',
    tertiary = '$tertiary',
    surface = '$surface',
    onPrimary = '$onPrimary',
    onSecondary = '$onSecondary',
    onTertiary = '$onTertiary',
    onSurface = '$onSurface',

    highlight = '$highlight',
    radius = '$radius',
    shadow = '$shadow',
    transition = '$transition'
}" > $themes/colors.lua

# Vim colors
echo "return {
set wallpaper = '$wallpaper'

set primary = '$primary'
set secondary = '$secondary'
set tertiary = '$tertiary'
set surface = '$surface'
set onPrimary = '$onPrimary'
set onSecondary = '$onSecondary'
set onTertiary = '$onTertiary'
set onSurface = '$onSurface'

set highlight = '$highlight'
set radius = '$radius'
set shadow = '$shadow'
set transition = '$transition'
}" > $themes/colors.vim

# Alacritty
echo "[colors.primary]
background = \"$primary\"
foreground = \"$onPrimary\"

[colors.cursor]
text = \"$primary\"
cursor = \"$onPrimary\"

[colors.vi_mode_cursor]
text = \"$primary\"
cursor = \"$onPrimary\"

[colors.search.matches]
foreground = \"$onSecondary\"
background = \"$secondary\"

[colors.search.focused_match]
foreground = \"#1e1e2e\"
background = \"#a6e3a1\"

[colors.footer_bar]
foreground = \"#1e1e2e\"
background = \"#a6adc8\"

[colors.hints.start]
foreground = \"#1e1e2e\"
background = \"#f9e2af\"

[colors.hints.end]
foreground = \"#1e1e2e\"
background = \"#a6adc8\"

[colors.selection]
text = \"#1e1e2e\"
background = \"#f5e0dc\"

[colors.normal]
black = \"#45475a\"
red = \"#f38ba8\"
green = \"#a6e3a1\"
yellow = \"#f9e2af\"
blue = \"#89b4fa\"
magenta = \"#f5c2e7\"
cyan = \"#94e2d5\"
white = \"#bac2de\"

[colors.bright]
black = \"#585b70\"
red = \"#f38ba8\"
green = \"#a6e3a1\"
yellow = \"#f9e2af\"
blue = \"#89b4fa\"
magenta = \"#f5c2e7\"
cyan = \"#94e2d5\"
white = \"#a6adc8\"

[[colors.indexed_colors]]
index = 16
color = \"#fab387\"

[[colors.indexed_colors]]
index = 17
color = \"#f5e0dc\"" > $themes/alacritty.toml

# Starship
echo "" > $themes/starship.toml
