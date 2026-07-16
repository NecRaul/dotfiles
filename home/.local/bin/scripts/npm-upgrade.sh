#!/bin/sh

npm list -g --depth=0 |
    grep -E '^[├└]' |
    sed -E 's/^[├└]── //; s/@[^@]+$//; /^tree-sitter$/d' |
    while read -r tool; do
        echo "Upgrading $tool"
        npm update -g "$tool"
        echo
    done
