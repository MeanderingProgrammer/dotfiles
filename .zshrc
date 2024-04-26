# ---- What gets displayed on line running command ---- #
PS1='%n@%m %~$ '

# ---- XDG Base Directory ---- #
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/tmp"

# ---- History configuration ---- #
zsh_state_home="${XDG_STATE_HOME}/zsh"
[[ ! -d $zsh_state_home ]] && mkdir -p $zsh_state_home

# man zshoptions
HISTSIZE=8000 # history kept in memory
SAVEHIST=5000 # history saved to file
HISTFILE="$zsh_state_home/history"
setopt append_history
setopt inc_append_history
setopt share_history

# ---- Run general shell setup ---- #
source ~/.config/shell/all.sh
