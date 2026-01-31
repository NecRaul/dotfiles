#!/bin/sh

pacman -Qneq >~/Documents/Github/Repos/dotfiles/install/pacman.txt
pacman -Qmeq | grep -v '^paru-debug$' >~/Documents/Github/Repos/dotfiles/install/aur.txt
uv tool list --show-extras |
  command grep -E '^[a-z]' |
  command sed -E 's/ v[^ ]+//; s/ \[extras: ([^]]+)\]/[\1]/; s/, +/,/g' >~/Documents/Github/Repos/dotfiles/install/uv.txt
