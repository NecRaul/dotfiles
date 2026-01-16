#!/bin/sh

set -- *.mkv

if [ ! -e "$1" ]; then
    echo "No MKV files found."
    exit 1
fi

if [ ! -f "Titles" ]; then
    echo "File 'Titles' not found in the current directory."
    exit 1
fi

num_files=$#
num_titles=$(wc -l <"Titles")

if [ "$num_files" -ne "$num_titles" ]; then
    echo "Count mismatch: $num_files files vs $num_titles titles."
    echo "Aborting renaming."
    exit 1
fi

i=1
while IFS= read -r title; do
    eval "old_title=\${$i}"
    new_title="$(printf "%02d" "$i"). $title.mkv"
    # shellcheck disable=SC2154
    mv -n "$old_title" "$new_title"
    echo "Renamed $old_title to $new_title"
    i=$((i + 1))
done <"Titles"
