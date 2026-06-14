#!/bin/sh

pacman -Qneq >~/Documents/Github/Repos/dotfiles/install/pacman.txt
pacman -Qmeq | grep -v '^paru-debug$' >~/Documents/Github/Repos/dotfiles/install/aur.txt
uv tool list --show-extras |
    grep -E '^[a-z]' |
    sed -E 's/ v[^ ]+//; s/ \[extras: ([^]]+)\]/[\1]/; s/, +/,/g; s#^gallery-dl\[extra\]#git+https://github.com/NecRaul/gallery-dl[extra]#' \
        >~/Documents/Github/Repos/dotfiles/install/uv.txt
