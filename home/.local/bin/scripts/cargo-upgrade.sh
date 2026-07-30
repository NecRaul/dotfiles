#!/bin/sh

if command -v cargo-binstall >/dev/null 2>&1; then
    use_binstall=true
else
    use_binstall=false
fi

cargo install --list |
    grep -E '^[a-zA-Z0-9_-]+ v[0-9]' |
    sed -E 's/ v.*//' |
    sort -i |
    while read -r tool; do
        echo "Upgrading $tool"
        if [ "$tool" = "wallpapers" ]; then
            cargo install --git https://github.com/awused/wallpapers --locked --no-default-features --features x11
        elif $use_binstall; then
            cargo binstall "$tool"
        else
            cargo install "$tool" --locked
        fi
        echo
    done
