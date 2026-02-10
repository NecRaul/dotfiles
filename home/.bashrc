#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi mode
set -o vi

# PS1 and PROMPT_COMMAND
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/\~}\007"'
eval "$(starship init bash)"

# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/aliases"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/clipboard"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/colors"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/history"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/less"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/path"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/sources"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/tmux"
# shellcheck disable=SC1091
source "$XDG_CONFIG_HOME/bash/xdg"

if [ -f "$XDG_CONFIG_HOME/bash/personal" ]; then
    # shellcheck disable=SC1091
    source "$XDG_CONFIG_HOME/bash/personal"
fi
