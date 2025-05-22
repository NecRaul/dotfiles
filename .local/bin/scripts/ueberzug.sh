#!/usr/bin/bash

padding_top=3
padding_bottom=0
padding_right=0
max_width=20
reserved_playlist_cols=31
reserved_cols_in_percent="false"
force_square="true"
square_alignment="top"
left_aligned="true"
padding_left=0

font_height=17
font_width=8

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
        action "add" \
        identifier "mpd_cover" \
        path "/tmp/mpd_cover.jpg" \
        x "$ueber_left" \
        y "$padding_top" \
        height "$ueber_height" \
        width "$ueber_width" \
        synchronously_draw "True" \
        scaler "forced_cover" \
        scaling_position_x "0.5"
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

    if [ -z "$font_height" ] || [ -z "$font_height" ]; then
        guess_font_size
    fi

    ueber_height=$(( term_lines - padding_top - padding_bottom ))
    ueber_width=$(( ueber_height * font_height / font_width ))
    ueber_left=$(( term_cols - ueber_width - padding_right ))

    if [ "$left_aligned" = "true" ]; then
        compute_geometry_left_aligned
    else
        compute_geometry_right_aligned
    fi

    apply_force_square_setting
}

compute_geometry_left_aligned() {
    ueber_left=$padding_left
    max_width_chars=$(( term_cols * max_width / 100 ))
    if [ "$max_width" != 0 ] &&
        [ $(( ueber_width + padding_right + padding_left )) -gt "$max_width_chars" ]; then
        ueber_width=$(( max_width_chars - padding_left - padding_right ))
    fi
}

compute_geometry_right_aligned() {
    if [ "$reserved_cols_in_percent" = "true" ]; then
        ueber_left_percent=$(printf "%.0f\n" $(calc "$ueber_left" / "$term_cols" '*' 100))
        if [ "$ueber_left_percent" -lt "$reserved_playlist_cols" ]; then
            ueber_left=$(( term_cols * reserved_playlist_cols / 100  ))
            ueber_width=$(( term_cols - ueber_left - padding_right ))
        fi
    else
        if [ "$ueber_left" -lt "$reserved_playlist_cols" ]; then
            ueber_left=$reserved_playlist_cols
            ueber_width=$(( term_cols - ueber_left - padding_right ))
        fi
    fi

    if [ "$max_width" != 0 ] && [ "$ueber_width" -gt "$max_width" ]; then
        ueber_width=$max_width
        ueber_left=$(( term_cols - ueber_width - padding_right ))
    fi
}

apply_force_square_setting() {
    if [ $force_square = "true" ]; then
        ueber_height=$(( ueber_width * font_width / font_height ))
        case "$square_alignment" in
            center)
                area=$(( term_lines - padding_top - padding_bottom ))
                padding_top=$(( padding_top + area / 2 - ueber_height / 2  ))
                ;;
            bottom)
                padding_top=$(( term_lines - padding_bottom - ueber_height ))
                ;;
            *) ;;
        esac
    fi
}

guess_font_size() {
    python <<END
import sys, struct, fcntl, termios

def get_geometry():
    fd_pty = sys.stdout.fileno()
    farg = struct.pack("HHHH", 0, 0, 0, 0)
    fretint = fcntl.ioctl(fd_pty, termios.TIOCGWINSZ, farg)
    rows, cols, xpixels, ypixels = struct.unpack("HHHH", fretint)
    return "{} {}".format(xpixels, ypixels)

output = get_geometry()
f = open("/tmp/ncmpcpp_geometry.txt", "w")
f.write(output)
f.close()
END

    term_width=$(awk '{print $1}' /tmp/ncmpcpp_geometry.txt)
    term_height=$(awk '{print $2}' /tmp/ncmpcpp_geometry.txt)
    rm "/tmp/ncmpcpp_geometry.txt"
    if ! is_font_size_successfully_computed; then
        echo "Failed to guess font size, try setting it in `basename $0` settings"
    fi
    approx_font_width=$(( term_width / term_cols ))
    approx_font_height=$(( term_height / term_lines ))

    term_xpadding=$(( ( - approx_font_width * term_cols + term_width ) / 2 ))
    term_ypadding=$(( ( - approx_font_height * term_lines + term_height ) / 2 ))

    font_width=$(( (term_width - 2 * term_xpadding) / term_cols ))
    font_height=$(( (term_height - 2 * term_ypadding) / term_lines ))
}

is_font_size_successfully_computed() {
    [ -n "$term_height" ] && [ -n "$term_width" ] &&
        [ "$term_height" != "0" ] && [ "$term_width" != "0" ]
}

calc() {
    awk "BEGIN{print $*}"
}

send_to_ueberzug() {
    old_IFS="$IFS"
    IFS="$(printf "\t")"
    echo "$*" > "$FIFO_UEBERZUG"
    IFS=${old_IFS}
}

kill_previous_instances >/dev/null 2>&1
display_cover_image 2>/dev/null
detect_window_resizes >/dev/null 2>&1
