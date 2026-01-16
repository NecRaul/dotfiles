#!/bin/sh
# Universal FZF previewer based on LF scope

set -C -f
IFS="$(printf '%b_' '\n')"
IFS="${IFS%_}"

path="$1"
width="$2"
# shellcheck disable=SC2034
height="$3"

[ -z "$path" ] && exit 1

case "$path" in
'~'*) path="$HOME${path#?}" ;;
esac

if [ -d "$path" ]; then
    eza --color=always --icons=always --no-quotes --group-directories-first -xlT --git -I \".git\" -L 1 "$path" && exit 0
fi

case "$(file --dereference --brief --mime-type -- "$path")" in
image/* | video/* | audio/* | application/octet-stream)
    mediainfo "$path"
    ;;
text/troff)
    man ./ "$path" | col -b
    ;;
text/* | */xml | application/json | application/javascript)
    bat --theme base16 --terminal-width "$((width - 2))" -f "$path"
    ;;
*/pdf)
    mediainfo "$path"
    ;;
*/epub+zip | */mobi*)
    unzip -l "$1"
    ;;
application/*zip | application/x-rar | application/vnd.rar | application/x-7z-compressed)
    atool -l "$1"
    ;;
*opendocument*)
    odt2txt "$path"
    ;;
application/pgp-encrypted)
    gpg -d -- "$path"
    ;;
application/msword)
    catdoc "$path"
    ;;
application/vnd.openxmlformats-officedocument.wordprocessingml.document)
    docx2txt "$path"
    ;;
application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
    ssconvert --export-type=Gnumeric_stf:stf_csv "$path" "fd://0" | bat --language=csv --theme base16
    ;;
application/x-iso9660-image)
    iso-info --no-header -l "$path"
    ;;
*)
    file -b "$path"
    stat "$path" | tail -n +2
    ;;
esac
