#!/bin/sh

sinks=$(wpctl status | awk '
/^[[:space:]]*├─ Sinks:/ {found=1; next}
/^[[:space:]]*├─ Sources:/ {found=0}
found && match($0, /[0-9]+\./) {
    id=substr($0, RSTART, RLENGTH-1)
    current=index($0, "*") ? 1 : 0
    name=substr($0, RSTART + RLENGTH)
    sub(/^[[:space:]]+/, "", name)
    sub(/[[:space:]]+\[vol:.*/, "", name)
    print id "|" current "|" name
}
')

[ -z "$sinks" ] && exit 1

count=$(printf '%s\n' "$sinks" | wc -l)

case "$count" in
0) exit 1 ;;
1) exit 0 ;;
2)
    id=$(
        printf '%s\n' "$sinks" |
            awk -F'|' '$2 == 0 { print $1; exit }'
    )
    wpctl set-default "$id"
    exit 0
    ;;
esac

selected=$(printf '%s\n' "$sinks" |
    awk -F'|' '{print $2 "|" $3}' |
    sort -t'|' -k1,1 |
    awk -F'|' '{print ($1 ? "*" : "") $2}' |
    dmenu -l 5 -p "Output:")

[ -z "$selected" ] && exit 0

id=$(printf '%s\n' "$sinks" |
    awk -F'|' -v name="$selected" '
    {
        display=($2 ? "*" : "") $3
        if (display == name) {
            print $1
            exit
        }
    }')

wpctl set-default "$id"
