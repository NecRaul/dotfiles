#!/bin/sh

for song in *.m4a *.flac; do
    ffmpeg -i "$song" -map_metadata 0 -b:a 320k "${song%.*}.mp3"
done
