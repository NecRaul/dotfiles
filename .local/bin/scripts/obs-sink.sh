#!/bin/bash


if pactl list modules short | grep -q "module-null-sink"; then
    pactl unload-module module-null-sink
    pactl unload-module module-loopback
else
    pactl load-module module-null-sink sink_name=OBS
    pactl load-module module-loopback source=OBS.monitor sink=alsa_output.pci-0000_08_00.3.3.analog-stereo
fi
