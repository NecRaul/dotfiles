#!/bin/sh

tmp_list=$(mktemp)
fd -t f >"$tmp_list"

rg --pcre2 '(?<=^|/)\d{13,15}(?=[ .m])[^/]*$' "$tmp_list" | sort >offender-epoch-millis
rg --pcre2 '(?<=^|/)\d{16}(?= )[^/]*$' "$tmp_list" | sort >offender-epoch-micros

rm "$tmp_list"
