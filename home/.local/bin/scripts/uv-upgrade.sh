#!/bin/sh

uv tool list |
    grep -E '^[a-z]' |
    cut -d' ' -f1 |
    sort -i |
    while read -r tool; do
        echo "Upgrading $tool"
        uv tool upgrade "$tool"
        echo
    done
