#!/bin/bash

mkdir -p output

for file in *.mkv; do
    output_file="output/$(basename -s .mkv "$file").mkv"
    mkvmerge -o "$output_file" \
        --audio-tracks $1 \
        --subtitle-tracks $2 \
        "$file"
done
