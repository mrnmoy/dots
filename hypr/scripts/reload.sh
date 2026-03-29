#!/bin/bash
killall -9 waybar
killall slurp grimp hyprpicker hyprshot
sleep 1
hyprparer & waybar & swaync-client -R & swaync-client -rs & hyprpanel -q; hyprpanel &
