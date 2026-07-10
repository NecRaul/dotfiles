#!/bin/sh

active_vpns=$(
    nmcli -t -f NAME,TYPE connection show --active |
        awk -F: '$2 == "vpn" || $2 == "wireguard" { print $1 }'
)

menu=$(
    nmcli -t -f NAME,TYPE connection show |
        awk -F: '$2 == "vpn" || $2 == "wireguard" { print $1 ":" $2 }' |
        sort |
        while IFS=: read -r name type; do
            case "$type" in
            wireguard)
                label="WireGuard"
                ;;
            vpn)
                service=$(nmcli -g vpn.service-type connection show "$name")
                case "$service" in
                *openvpn*)
                    label="OpenVPN"
                    ;;
                *)
                    label="VPN"
                    ;;
                esac
                ;;
            *)
                label="VPN"
                ;;
            esac
            if printf "%s\n" "$active_vpns" | grep -Fxq "$name"; then
                printf "%s (%s) [Connected]\n" "$name" "$label"
            else
                printf "%s (%s)\n" "$name" "$label"
            fi
        done
)

choice=$(printf "%s\n" "$menu" | dmenu -l 8 -p "VPN:")

[ -z "$choice" ] && exit 0

conn=$(printf "%s" "$choice" | sed 's/ \[Connected\]//; s/ (.*)//')

if printf "%s\n" "$active_vpns" | grep -Fxq "$conn"; then
    nmcli connection down "$conn"
else
    for active_vpn in $active_vpns; do
        nmcli connection down "$active_vpn"
    done
    nmcli connection up "$conn"
fi
pkill -RTMIN+4 dwmblocks
