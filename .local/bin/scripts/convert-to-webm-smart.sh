#!/bin/sh

script=$(basename "$0")
input=$1
crf=$2
scale=$3
output="$(basename -- "$input" | sed 's/\.[^.]*$//')"

if [ "$#" -lt 2 ]; then
    printf '\033[1mUsage: %s input crf\033[0m scale (optional)\n' "$script"
    exit 1
fi

metadata_title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$input")

if [ -z "$metadata_title" ]; then
    metadata_title="$output"
fi

if [ -z "$3" ]; then
    scale=""
else
    scale="-vf scale=$3"
fi

overall_bitrate=$(ffprobe -v error -show_entries format=bit_rate -of default=noprint_wrappers=1:nokey=1 "$input")
video_bitrate=$(ffprobe -v error -select_streams v:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$input")
audio_exists=$(ffprobe -v error -select_streams a -show_entries stream=codec_type -of csv=p=0 "$input" | grep -q . && echo 1 || echo 0)

if [ "$audio_exists" -eq 1 ]; then
    audio_bitrate=$(ffprobe -v error -select_streams a:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$input")
else
    audio_bitrate=""
fi

if [ "$video_bitrate" != "N/A" ]; then
    video="$((video_bitrate / 1000))k"
    if [ "$audio_exists" -eq 1 ]; then
        if [ "$audio_bitrate" != "N/A" ]; then
            audio_bitrate=$((audio_bitrate / 1000))
            [ "$audio_bitrate" -lt 45 ] && audio_bitrate=45
        else
            audio_bitrate=$(((overall_bitrate - video_bitrate) / 1000))
            if [ "$audio_bitrate" -lt 0 ]; then
                audio_bitrate=0
            fi
        fi
        audio="-c:a libopus -b:a ${audio_bitrate}k"
    else
        audio="-an"
    fi
else
    input_size_bits=$(($(stat --printf="%s" "$input" 2>/dev/null || stat -f%z "$input") * 8))
    duration_seconds=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input" | cut -d '.' -f1)
    overall_bitrate=$((input_size_bits / duration_seconds / 1000))
    if [ "$audio_exists" -eq 1 ]; then
        video_bitrate=$((overall_bitrate * 19 / 20))
        audio_bitrate=$((overall_bitrate / 20))
        [ "$audio_bitrate" -lt 45 ] && audio_bitrate=45
        video="-b:v ${video_bitrate}k"
        audio="-c:a libopus -b:a ${audio_bitrate}k"
    else
        video="${overall_bitrate}k"
        audio="-an"
    fi
fi

ffmpeg_args="-y -profile:v 2 -g 300 -pix_fmt yuv420p10le -lag-in-frames 25 -threads 4 -speed 1 -auto-alt-ref 6 -row-mt 1 -tile-columns 2 -tile-rows 2 -sn"

# shellcheck disable=SC2086
ffmpeg -i "$input" -pass 1 $ffmpeg_args -metadata title="$metadata_title" $scale -c:v libvpx-vp9 -b:v $video -crf $crf -an -f webm /dev/null
# shellcheck disable=SC2086
ffmpeg -i "$input" -pass 2 $ffmpeg_args -metadata title="$metadata_title" $scale -c:v libvpx-vp9 -b:v $video -crf $crf $audio "$output.webm"
