#!/bin/bash

fd --type f --extension mp3 --extension song . | sort | while read -r song; do
    disc=$(ffprobe -v quiet -show_entries format_tags=disc -of default=noprint_wrappers=1:nokey=1 "$song")
    if echo "$disc" | grep -qP '^(0[0-9]*/[0-9]+|[0-9]+/0[0-9]+)$'; then
        echo "$song: $disc"
    fi
done > offender-disc.txt
