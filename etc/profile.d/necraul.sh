# PATH Setup
if [ -d "$HOME/.local/bin" ]; then
    append_path "$HOME/.local/bin"
    for d in "$HOME/.local/bin"/*/; do
        [ -d "$d" ] && append_path "${d%/}"
    done
fi
if [ -d "$HOME/Documents/Github/Gists" ]; then
    append_path "$HOME/Documents/Github/Gists"
    for d in "$HOME/Documents/Github/Gists"/*/; do
        [ -d "$d" ] && append_path "${d%/}"
    done
fi
export PATH

# XDG Setup
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Default programs
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export MUSIC_DIR="$HOME/Music"

# Sources
source "$XDG_CONFIG_HOME/fzf/fzfrc"

# Misc
export QT_QPA_PLATFORMTHEME=qt6ct
export NSXIV_OPTS="-aqb"
export MOZ_USE_XINPUT2="1"
