# shellcheck shell=sh

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/autostart"
mkdir -p "$cache_dir"

run() {
    cmd="$1"
    shift
    logfile="$cache_dir/${cmd}.log"
    if ! pidof -sx "$cmd" >/dev/null; then
        "$@" >"$logfile" 2>&1 &
    fi
}

run_blocking() {
    cmd="$1"
    shift
    logfile="$cache_dir/${cmd}.log"
    if ! pidof -sx "$cmd" >/dev/null; then
        "$@" >"$logfile" 2>&1
    fi
}
