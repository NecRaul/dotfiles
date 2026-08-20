#!/bin/sh

npm update -g pnpm
pnpm list -g --depth=0 |
    grep -E '^[├└]' |
    sed -E 's/^[├└]── //; s/@[^@]+$//; /^tree-sitter$/d' |
    sort -i |
    while read -r tool; do
        echo "Upgrading $tool"
        pnpm update -g "$tool"
        echo
    done
