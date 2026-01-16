#!/bin/bash

files=(./*.mp3 ./*.flac)

if [ -e "${files[0]}" ]; then
    format=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "${files[0]}")
    if [[ "$format" == "mjpeg" ]]; then
        ext="jpg"
    else
        ext="png"
    fi
    ffmpeg -i "${files[0]}" -an -vcodec copy "Cover.$ext"
fi
