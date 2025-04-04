#!/bin/bash

for file in *; do
    [[ -d "$file" ]] && continue

    base="${file%.*}"
    ext="${file##*.}"

    [[ "$file" == "$ext" ]] && ext=""

    [[ "$base" =~ ^[0-9]+$ ]] || continue

    len=${#base}
    missing=$((16 - len))

    if (( missing > 0 )); then
        random_digits=$(shuf -i 0-9 -n "$missing" | tr -d '\n')
        new_base="$base$random_digits"
        new_file="$new_base"
        [[ -n "$ext" ]] && new_file+=".$ext"

        mv -n "$file" "$new_file"
    fi
done
