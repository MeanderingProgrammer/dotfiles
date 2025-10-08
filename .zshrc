# ---- displayed on line running command ---- #
PS1='%n@%m %~$ '

# ----                 xdg base directory                  ---- #
# ---- https://wiki.archlinux.org/title/XDG_Base_Directory ---- #
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"    # configuration data
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"   # data that should persist between restarts
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}" # data that is not important or portable enough
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"       # non-essential cached data
if [[ -z "${XDG_RUNTIME_DIR}" ]]; then                          # non-essential runtime and other data
    if [[ -w "/tmp" ]]; then
        export XDG_RUNTIME_DIR="/tmp/user/$(id -u)"
    else
        export XDG_RUNTIME_DIR="${TMPDIR}"
    fi
fi

# ----      utility functions       ---- #
# ---- written longer for debugging ---- #
has() {
    if command -v "${1}" > /dev/null; then
        return 0
    else
        return 1
    fi
}

safe_directory() {
    if [[ -n "${1}" && ! -d "${1}" ]]; then
        mkdir -p "${1}"
        if [[ -n "${2}" ]]; then
            chmod "${2}" "${1}"
        fi
    fi
}

safe_source() {
    if [[ -f "${1}" ]]; then
        source "${1}"
    fi
}

time_cmd() {
    local name="${1}"
    shift
    if [[ -o interactive ]] && has "gdate"; then
        local t1=$(gdate +%s%3N)
        "$@"
        local t2=$(gdate +%s%3N)
        echo "${name} time: $((t2 - t1))ms"
    else
        "$@"
    fi
}

# ---- xdg resources ---- #
safe_directory "${XDG_RUNTIME_DIR}" "700"

# ---- history configuration ---- #
# ----    man zshoptions     ---- #
zsh_state_home="${XDG_STATE_HOME}/zsh"
safe_directory "${zsh_state_home}"

HISTSIZE=8000 # history kept in memory
SAVEHIST=5000 # history saved to file
HISTFILE="${zsh_state_home}/history"
setopt append_history
setopt inc_append_history
setopt share_history

# ---- source all shell configurations ---- #
shell_init() {
    for source_file in "${XDG_CONFIG_HOME}"/zsh/*.zsh; do
        safe_source "${source_file}"
    done
}

time_cmd "init" shell_init
