#!/bin/sh

for file in *; do
    [ -d "$file" ] && continue

    base="${file%.*}"
    ext="${file##*.}"

    [ "$file" = "$ext" ] && ext=""

    case "$base" in
    "" | *[!0-9]*) continue ;;
    esac

    len=${#base}
    missing=$((16 - len))

    if [ "$missing" -gt 0 ]; then
        random_digits=$(shuf -i 0-9 -n "$missing" | tr -d '\n')
        new_base="$base$random_digits"
        new_file="$new_base"
        [ -n "$ext" ] && new_file="$new_file.$ext"

        mv -n "$file" "$new_file"
    fi
done
