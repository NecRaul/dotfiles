#!/bin/bash

script=$(basename "$0")
input=$1
crf=$2
video=$3
audio=$4
scale=$5
output="$(basename -- "$1" | sed 's/\.[^.]*$//')"

if [ "$#" -lt 3 ]; then
    echo -e "\e[1mUsage: $script video crf vb\e[0m ab (optional) scale (optional)"
    exit 1
fi

if [ -z "$4" ]; then
    audio="-an"
else
    audio="-c:a libvorbis -b:a $4"
fi

if [ -z "$5" ]; then
    scale=""
else
    scale="-vf scale=-1:$5"
fi

ffmpeg -i "$input" -pass 1 -metadata title="$output" -y $scale -profile:v 2 -g 300 -pix_fmt yuv420p10le -lag-in-frames 25 -threads 4 -speed 1 -auto-alt-ref 6 -row-mt 1 -tile-columns 2 -tile-rows 2 -sn -c:v libvpx-vp9 -b:v $video -crf $crf -an -f webm /dev/null
ffmpeg -i "$input" -pass 2 -metadata title="$output" -y $scale -profile:v 2 -g 300 -pix_fmt yuv420p10le -lag-in-frames 25 -threads 4 -speed 1 -auto-alt-ref 6 -row-mt 1 -tile-columns 2 -tile-rows 2 -sn -c:v libvpx-vp9 -b:v $video -crf $crf $audio "$output.webm"
