#!/bin/sh

for bin in "$(go env GOBIN)/"*; do
    go version -m "$bin" 2>/dev/null
done |
    grep -E '^\s+path\s' |
    sed -E 's/^[[:space:]]*path[[:space:]]+(.+)$/\1@latest/' |
    sort -i |
    while read -r tool; do
        echo "Upgrading $tool"
        go install "$tool"
        echo
    done
