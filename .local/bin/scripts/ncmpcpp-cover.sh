#!/bin/sh

padding_top=3
padding_bottom=0
padding_left=0
padding_right=0
max_width=20
force_square="true"
square_alignment="top"
font_height=17
font_width=8

cover_path="$XDG_CACHE_HOME/ncmpcpp/$(mpc --format "%albumartist%_%album%" current | sed "s/[\/:*~!?,.'\"<>| ]//g").jpg"

kill_previous_instances() {
    script_name=$(basename "$0")
    for pid in $(pidof -x "$script_name"); do
        if [ "$pid" != $$ ]; then
            kill -15 "$pid"
        fi
    done
}

display_cover_image() {
    compute_geometry
    send_to_ueberzug \
        "$ueber_left" \
        "$padding_top" \
        "$ueber_width" \
        "$ueber_height" \
        "$cover_path"
}

detect_window_resizes() {
    {
        trap 'display_cover_image' WINCH
        while :; do sleep .1; done
    } &
}

compute_geometry() {
    unset LINES COLUMNS
    term_lines=$(tput lines 2>/dev/tty)
    term_cols=$(tput cols 2>/dev/tty)

    ueber_height=$((term_lines - padding_top - padding_bottom))
    ueber_width=$((ueber_height * font_height / font_width))
    ueber_left=$padding_left

    max_width_chars=$((term_cols * max_width / 100))

    if [ "$max_width" != 0 ] && [ $((ueber_width + padding_right + padding_left)) -gt "$max_width_chars" ]; then
        ueber_width=$((max_width_chars - padding_left - padding_right))
    fi

    apply_force_square_setting
}

apply_force_square_setting() {
    if [ $force_square = "true" ]; then
        case "$square_alignment" in
        center)
            area=$((term_lines - padding_top - padding_bottom))
            padding_top=$((padding_top + area / 2 - ueber_height / 2))
            ;;
        bottom)
            padding_top=$((term_lines - padding_bottom - ueber_height))
            ;;
        *) ;;
        esac
    fi
}

send_to_ueberzug() {
    printf '{"action": "add", "identifier": "PREVIEW", "x": %d, "y": %d, "width": %d, "height": %d, "scaler": "contain", "path": "%s"}\n' "$1" "$2" "$3" "$4" "$5" >"$NCMPCPP_UEBERZUG_FIFO"
}

# kill_previous_instances >/dev/null 2>&1
display_cover_image 2>/dev/null
detect_window_resizes >/dev/null 2>&1
