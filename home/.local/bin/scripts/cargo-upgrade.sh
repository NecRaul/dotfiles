#!/bin/sh

cargo install --list |
    grep -E '^[a-zA-Z0-9_-]+ v[0-9]' |
    sed -E 's/ v.*//' |
    sort -i |
    while read -r tool; do
        echo "Upgrading $tool"
        cargo install "$tool"
        echo
    done
