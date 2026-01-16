#!/bin/sh

fd --type f --extension mp3 --extension flac . | sort | while read -r song; do
    track=$(ffprobe -v quiet -show_entries format_tags=track -of default=noprint_wrappers=1:nokey=1 "$song")
    if echo "$track" | grep -qP '^(0[0-9]*/[0-9]+|[0-9]+/0[0-9]+)$'; then
        echo "$song: $track"
    fi
done >offender-track
