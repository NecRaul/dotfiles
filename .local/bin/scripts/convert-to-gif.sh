#!/bin/bash

script=$(basename "$0")
input=$1
scale=$2
output="$(basename -- "$1" | sed 's/\.[^.]*$//')"

if [ "$#" -lt 1 ]; then
    echo -e "\e[1mUsage: $script input\e[0m scale (optional)"
    exit 1
fi

if [ -z "$2" ]; then
    scale=""
else
    scale=",scale=$2:flags=lanczos"
fi

fps=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "$input" | bc -l | awk '{print int($1)}')

palette_args="fps=$fps$scale,palettegen"
gif_args="fps=$fps$scale[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=5"

ffmpeg -y -i "$input" -vf "$palette_args" "$output.png"
ffmpeg -y -i "$input" -i "$output.png" -lavfi "$gif_args" "$output.gif"
rm "$output.png"
