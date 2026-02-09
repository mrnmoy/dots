#!/usr/bin/env bash

set -x  # Show commands as they run

IMAGE="$HOME/.config/nvim/logo.png"
X=10
Y=5
W=50
H=20

# Adding the correct parameters
ueberzugpp layer --parser bash 0<<EOF
add [identifier]="nvim_logo" [x]="$X" [y]="$Y" [path]="$IMAGE" [width]="$W" [height]="$H"
EOF

