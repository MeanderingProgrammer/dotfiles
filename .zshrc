# ---- What gets displayed on line running command ---- #
PS1='%n@%m %~$ '

# ---- XDG Base Directory ---- #
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"    # Configurations
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"       # Non-essential (cached) data
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"   # State data that should persist between restarts
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}" # State data but is not important or portable enough
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}"  # Non-essential runtime files and other file objects

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

# ---- Run main shell setup ---- #
shell_main() {
    source "${XDG_CONFIG_HOME}/shell/all.sh"
}

if [[ -x "$(command -v gdate)" ]]; then
    sh_start_time=$(gdate +%s%3N)
    shell_main
    sh_end_time=$(gdate +%s%3N)
    echo "Start time: $((sh_end_time - sh_start_time))ms"
else
    shell_main
fi
