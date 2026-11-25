#!/usr/bin/bash

CACHE_DIR="$HOME/.cache/thumbnails"

readarray -t files <<< $(find "$HOME/$1" -maxdepth 1 -type f -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp")
files=($(printf "%s\n" "${files[@]}" | sort -r -t'#' -k2,2))

md5() {
    echo -n "$1" | md5sum | awk '{print $1}'
}

urlencode() {
    local str="$1"
    local encoded=""
    local c
    for ((i=0; i<${#str}; i++)); do
        c="${str:$i:1}"
        case "$c" in
            [a-zA-Z0-9.~_-]|/|'('|')'|'*') encoded+="$c" ;;
            *) printf -v hex '%%%02X' "'${c}'"; encoded+="$hex" ;;
        esac
    done
    echo "$encoded"
}

for f in "${files[@]}"; do 
    # n=${f/\/*\//}
    # hash="$(md5 ${n/.*/})"
    
    encoded_path="$(urlencode "$f")"
    uri="file://$encoded_path"

    hash="$(md5 "$uri")"

    out="$CACHE_DIR/$hash.png"
    # out="$CACHE_DIR/${n/.*/}.png"

    mkdir -p "$CACHE_DIR"
    magick $f -resize "128x128" $out
    echo $out
done
