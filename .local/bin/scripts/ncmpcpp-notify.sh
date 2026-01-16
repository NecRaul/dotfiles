#!/bin/sh

artist="$(mpc --format "%artist%" current)"
title="$(mpc --format "%title%" current)"

cover_path="$XDG_CACHE_HOME/ncmpcpp/$(mpc --format "%albumartist%_%album%" current | sed "s/[\/:*~!?,.'\"<>| ]//g").jpg"

if [ ! -f "$cover_path" ]; then
    song="$(mpc --format "$MUSIC_DIR/"%file% current)"
    ext="$(mpc --format %file% current | sed 's/^.*\.//')"
    if [ "$ext" = "flac" ]; then
        temp_cover="${cover_path%.jpg}_temp.jpg"
        metaflac --export-picture-to="$temp_cover" "$song" >/dev/null 2>&1
        ffmpeg -y -i "$temp_cover" -vf scale=500:500 "$cover_path" >/dev/null 2>&1
        rm -f "$temp_cover"
    else
        ffmpeg -y -i "$song" -vf scale=500:500 "$cover_path" >/dev/null 2>&1
    fi
fi

notify-send --replace-id=12345 -i "$cover_path" "$artist" "$title"
