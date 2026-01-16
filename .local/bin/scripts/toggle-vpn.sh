#!/bin/sh

active_connections=$(nmcli connection show --active | wc -l)
total_connections=$(nmcli connection show | wc -l)

if [ "$active_connections" -eq "$total_connections" ]; then
    nmcli connection down kuroneko-vpn
else
    nmcli connection up kuroneko-vpn
fi
