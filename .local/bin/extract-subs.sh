#!/bin/bash

for file in *.mkv; do
    filename="${file%.*}"
    ffmpeg -i "$file" "$filename.ass"
done
