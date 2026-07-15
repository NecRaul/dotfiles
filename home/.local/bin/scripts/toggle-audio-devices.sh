#!/bin/sh

speakers_id=$(wpctl status | grep Speakers | grep -oE '[0-9]+' | head -1)
headphones_id=$(wpctl status | grep Headphones | grep -oE '[0-9]+' | head -1)
current_id=$(wpctl status | grep -F "*" | grep -oE '[0-9]+' | head -1)

if [ "$current_id" = "$speakers_id" ]; then
    wpctl set-default "$headphones_id"
elif [ "$current_id" = "$headphones_id" ]; then
    wpctl set-default "$speakers_id"
fi
