#!/usr/bin/bash

ext="$(mpc --format %file% current | sed 's/^.*\.//')"
song="$(mpc --format "$MUSIC_DIR/"%file% current)"
artist="$(mpc current | awk -F '-' '{gsub(/^[ \t]+|[ \t]+$/, "", $1); print $1}')"
title="$(mpc current | awk -F '-' '{sub(/^[^-]*-/, ""); gsub(/^[ \t]+|[ \t]+$/, ""); print}')"

if [ "$ext" = "flac" ]; then
    metaflac --export-picture-to=/tmp/mpd_cover.jpg "$song" >/dev/null 2>&1
else
    ffmpeg -y -i "$song" /tmp/mpd_cover.jpg >/dev/null 2>&1
fi

notify-send --replace-id=12345 -i /tmp/mpd_cover.jpg "$artist" "$title"
