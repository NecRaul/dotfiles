#!/bin/bash

running_source=$(pactl list short sources | grep output | awk '/RUNNING/ {print $2}')
running_sink=$(pactl list short sinks | awk '/RUNNING/ {print $2}')

speakers=$(pactl list short sinks | grep alsa_output.pci-0000_06 | awk '{print $2}')

headphones=$(pactl list short sinks | grep alsa_output.pci-0000_08 | awk '{print $2}')

if [ "$running_source" = "$speakers.monitor" ] && [ "$running_sink" = "$speakers" ]; then
    pactl set-default-source "$headphones.monitor"
    pactl set-default-sink "$headphones"
else
    pactl set-default-source "$speakers.monitor"
    pactl set-default-sink "$speakers"
fi
