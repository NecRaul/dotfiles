#!/bin/sh

pacman -Qneq >~/Documents/Github/Repos/dotfiles/install/pacman.txt
pacman -Qmeq | grep -v '^paru-debug$' >~/Documents/Github/Repos/dotfiles/install/aur.txt
uv tool list --show-extras |
    grep -E '^[a-z]' |
    sed -E 's/ v[^ ]+//; s/ \[extras: ([^]]+)\]/[\1]/; s/, +/,/g; s#^gallery-dl\[extra\]#git+https://github.com/NecRaul/gallery-dl[extra]#' \
        >~/Documents/Github/Repos/dotfiles/install/uv.txt
npm list -g --depth=0 |
    grep -E '^[├└]' |
    sed -E 's/^[├└]── //; s/@[^@]+$//; /^tree-sitter$/d' \
        >~/Documents/Github/Repos/dotfiles/install/npm.txt
cargo install --list |
    grep -E '^[a-zA-Z0-9_-]+ v[0-9]' |
    sed -E 's/ v.*//' \
        >~/Documents/Github/Repos/dotfiles/install/cargo.txt
