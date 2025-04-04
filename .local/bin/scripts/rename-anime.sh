#!/bin/bash

mkv_files=()

for file in *.mkv; do
    mkv_files+=("$file")
done

if [ ! -f "Titles" ]; then
    echo "File 'Titles' not found in the current directory."
    exit 1
fi

titles=()

while IFS= read -r line; do
    titles+=("$line")
done <"Titles"

if [ ${#mkv_files[@]} -ne ${#titles[@]} ]; then
    echo "Not enough MKV mkv_files for renaming."
    exit 1
fi

for ((i = 0; i < ${#titles[@]}; i++)); do
    old_title="${mkv_files[i]}"
    new_title="$(printf "%02d" "$((i + 1))"). ${titles[i]}.mkv"
    mv -n "$old_title" "$new_title"
    echo "Renamed $old_title to $new_title"
done
