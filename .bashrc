#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi mode
set -o vi

# Aliases
alias sudo="sudo " # this is to make sudo vim do sudo nvim instead
alias pacman="pacman --color=auto"
alias vim="nvim"
alias ls="eza --color=auto --icons=auto --no-quotes --group-directories-first -x"
alias ld="eza --color=auto --icons=auto --no-quotes --group-directories-first -xa | grep -E \"^\.\""
alias la="eza --color=auto --icons=auto --no-quotes --group-directories-first -xa"
alias ll="eza --color=auto --icons=auto --no-quotes --group-directories-first -xlh --git"
alias lt="eza --color=auto --icons=auto --no-quotes --group-directories-first -xT -L 3"
alias lla="eza --color=auto --icons=auto --no-quotes --group-directories-first -xalh --git"
alias llt="eza --color=auto --icons=auto --no-quotes --group-directories-first -xlhT --git -I \".git\" -L 3"
alias lta="eza --color=auto --icons=auto --no-quotes --group-directories-first -xaT -I \".git\" -L 3"
alias llta="eza --color=auto --icons=auto --no-quotes --group-directories-first -xalhT --git -I \".git\" -L 3"
alias mkdir="mkdir -p"
alias yt-dlp="yt-dlp --embed-metadata"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias python="python3"
alias pip="pip3"
alias pynps="pynps -c ps3 -r usa"
alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"

# Colors
export RED="\[\e[1;31m\]"
export GREEN="\[\e[1;38;2;0;255;0m\]"
export BLUE="\[\e[1;34m\]"
export YELLOW="\[\e[1;33m\]"
export PURPLE="\[\e[1;95m\]"
export RESET="\[\e[0m\]"

# PS1
export PS1="${YELLOW}[${RED}\u${PURPLE}@${BLUE}\h ${PURPLE}\W${YELLOW}]${PURPLE}\$ ${BLUE}\$(__git_branch)${YELLOW}\$(__git_state)${RESET}"

# git-neko/gist-neko
export GITHUB_USERNAME=gu
export GITHUB_PERSONAL_ACCESS_TOKEN=gpat

# Default programs
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export MUSIC_DIR="$HOME/Music"

# History
export HISTTIMEFORMAT=$(echo -e "\033[0;33m"[%F %T] "\033[0m")
export HISTSIZE=10000
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth

# PATH
export PATH=$PATH:"$HOME/.dotnet/"
export PATH=$PATH:"$HOME/.dotnet/tools"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.local/share/npm/bin"
export PATH=$PATH:"$HOME/.nuget/"
export PATH=$PATH:"$XDG_DATA_HOME/go"

# XDG Setup
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# XDG_CACHE_HOME
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# XDG_CONFIG_HOME
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"

# XDG_DATA_HOME
export AZURE_CONFIG_DIR="$XDG_DATA_HOME/azure"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_DATA_HOME/history"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

# FZF colors
FG_COLOR="#D0D0D0"
BG_COLOR="#121212"
HL_COLOR="$(sed -n '6p' "${HOME}/.cache/wal/colors")"
FG_PLUS_COLOR="#D0D0D0"
BG_PLUS_COLOR="#262626"
HL_PLUS_COLOR="$(sed -n '2p' "${HOME}/.cache/wal/colors")"
INFO_COLOR="$(sed -n '2p' "${HOME}/.cache/wal/colors")"
PROMPT_COLOR="$(sed -n '2p' "${HOME}/.cache/wal/colors")"
POINTER_COLOR="$(sed -n '11p' "${HOME}/.cache/wal/colors")"
MARKER_COLOR="$(sed -n '7p' "${HOME}/.cache/wal/colors")"
SPINNER_COLOR="$(sed -n '4p' "${HOME}/.cache/wal/colors")"
HEADER_COLOR="$(sed -n '11p' "${HOME}/.cache/wal/colors")"

# FZF options
export FZF_DEFAULT_OPTS="--height=75% --layout=reverse --info=inline --border --margin=1 --padding=1 \
--color=fg:$FG_COLOR,bg:$BG_COLOR,hl:$HL_COLOR \
--color=fg+:$FG_PLUS_COLOR,bg+:$BG_PLUS_COLOR,hl+:$HL_PLUS_COLOR \
--color=info:$INFO_COLOR,prompt:$PROMPT_COLOR,pointer:$POINTER_COLOR \
--color=marker:$MARKER_COLOR,spinner:$SPINNER_COLOR,header:$HEADER_COLOR"

# Mozilla smooth scrolling/touchpads
export MOZ_USE_XINPUT2="1"

# External sources for bashrc
source "$XDG_CONFIG_HOME/git/git-prompt.sh"
source "$XDG_DATA_HOME/blesh/ble.sh" --rcfile "$XDG_CONFIG_HOME/blesh/init.sh"
source "$HOME/.local/bin/zoxide.sh"

# Start a tmux session when bash starts
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    last_session=$(tmux ls | awk -F: '{print $1}' | tail -n 1)
    if [ -z "$last_session" ]; then
        session_name=0
    else
        session_name=$((last_session + 1))
    fi
    exec tmux new-session -s "$session_name" >/dev/null 2>&1
fi

# Macros to enable yanking, killing and putting
# to and from the system clipboard in vi-mode.
# Only supports yanking and killing the whole line.
paste_from_clipboard() {
    local shift=$1
    local head=${READLINE_LINE:0:READLINE_POINT+shift}
    local tail=${READLINE_LINE:READLINE_POINT+shift}
    local paste=$(xclip -out -selection clipboard)
    local paste_len=${#paste}
    READLINE_LINE=${head}${paste}${tail}
    let READLINE_POINT+=$paste_len+$shift-1
}

yank_line_to_clipboard() {
    echo $READLINE_LINE | xclip -in -selection clipboard
}

kill_line_to_clipboard() {
    yank_line_to_clipboard
    READLINE_LINE=""
}

bind -m vi-command -x "\"P\": paste_from_clipboard 0"
bind -m vi-command -x "\"p\": paste_from_clipboard 1"
bind -m vi-command -x "\"yy\": yank_line_to_clipboard"
bind -m vi-command -x "\"dd\": kill_line_to_clipboard"
