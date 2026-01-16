#!/bin/sh

for file in [0-9]*\ *; do
    new_name="${file%% *}.${file##*.}"
    mv -n "$file" "$new_name"
done
