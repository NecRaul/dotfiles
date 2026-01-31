#!/bin/sh

tmp_list=$(mktemp)
fd -t f >"$tmp_list"

grep -P '(?<=^|/)\d{13,15}(?=[ .m])[^/]*$' "$tmp_list" | sort >offender-epoch-millis
grep -P '(?<=^|/)\d{16}(?= )[^/]*$' "$tmp_list" | sort >offender-epoch-micros

rm "$tmp_list"
