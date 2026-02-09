paperpath="$HOME/.config/hypr/background.jpg"
ovWidth=3840
ovHeight=2160
ovRes="$ovWidth"x"$ovHeight"
res=`identify -format "%wx%h\n" $1`
resArr=(${res//x/ })

if [ $res != $ovRes ]
then
    if [ $((resArr[0])) -gt $ovWidth ] || [ $((resArr[1])) -gt $ovHeight ]
    then
        echo "imare too large"
        echo "cropping"
        magick $1 -gravity center -crop 3840x2160+0+0 $paperpath
    else
        echo "imare too small"
        echo "resizing"
        magick $1 -resize 3840x2160 $paperpath
    fi
else
    cp $1 $paperpath
fi



echo "1: ltr, 2: center, 3: rtl"
read mode
case $mode in
    "1")
        mode="ltr"
        ;;
    "2")
        mode="ctr"
        ;;
    "3")
        mode="rtl"
        ;;
    *)
        echo -n "invalid"
        ;;
esac

magick -background none $paperpath "$DOTFILES/media/overlays/grub-overlay-$mode.pdf" -layers flatten background.jpg

#grub
# sudo cp background.jpg "/usr/share/grub/themes/akantha/background.jpg"

# magick -background none $paperpath overlays/ventoy-overlay.png -layers flatten background.jpg
# magick -background none $paperpath overlays/sddm-overlay.png -layers flatten background.jpg
# magick -background none $paperpath overlays/hyprlock-overlay.png -layers flatten background.jpg
