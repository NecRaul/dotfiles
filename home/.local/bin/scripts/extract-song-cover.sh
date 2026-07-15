#!/bin/sh

set -- ./*.mp3 ./*.flac

if [ -e "$1" ]; then
    format=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$1")
    if [ "$format" = "mjpeg" ]; then
        ext="jpg"
    else
        ext="png"
    fi
    ffmpeg -i "$1" -an -vcodec copy "Cover.$ext"
fi
