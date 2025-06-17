# ---- gets displayed on line running command ---- #
PS1='%n@%m %~$ '

# ---- xdg base directory ---- #
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"    # configuration data
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"   # data that should persist between restarts
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}" # data that is not important or portable enough
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"       # non-essential cached data
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}"  # non-essential runtime and other data

# ---- locale ---- #
export LANG="${LANG:-en_US.UTF-8}"

# ---- history configuration ---- #
zsh_state_home="${XDG_STATE_HOME}/zsh"
[[ ! -d $zsh_state_home ]] && mkdir -p $zsh_state_home

# man zshoptions
HISTSIZE=8000 # history kept in memory
SAVEHIST=5000 # history saved to file
HISTFILE="$zsh_state_home/history"
setopt append_history
setopt inc_append_history
setopt share_history

# ---- run main shell setup ---- #
init_shell() {
    local source_file="${XDG_CONFIG_HOME}/shell/init.sh"
    source "${source_file}"
}

if [[ -x "$(command -v gdate)" ]]; then
    shell_start=$(gdate +%s%3N)
    init_shell
    shell_end=$(gdate +%s%3N)
    echo "start time: $((shell_end - shell_start))ms"
else
    init_shell
fi
