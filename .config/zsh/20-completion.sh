# ---- completions ---- #

zsh_cache_home="${XDG_CACHE_HOME}/zsh"
if [[ ! -d $zsh_cache_home ]]; then
    mkdir -p $zsh_cache_home
fi

zsh_comp_home="${XDG_DATA_HOME}/completions"
if [[ ! -d $zsh_comp_home ]]; then
    mkdir -p $zsh_comp_home
fi

# add completion directories
if [[ -n $HOMEBREW_PREFIX ]]; then
    FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi
if [[ -x "$(command -v rustc)" ]]; then
    FPATH="$(rustc --print sysroot)/share/zsh/site-functions:${FPATH}"
fi

# man zshcompsys
zstyle ':completion:*' cache-path "${zsh_cache_home}/compcache"
autoload -Uz compinit && compinit -d "${zsh_cache_home}/compdump"

# add completion files
opam_comp="${OPAMROOT}/opam-init/complete.zsh"
if [[ -f $opam_comp ]]; then
    source "${opam_comp}"
fi

# update generated completions weekly
out_of_date() {
    [[ ! -f $1 ]] && return 0
    local current=$(date +%s)
    local modified=$(date -r $1 +%s)
    (( current - modified >= 604800 ))
}

click_enabled() {
    # skip if python is not installed
    [[ -x "$(command -v python)" ]] || return 1
    # skip if pip is not installed
    [[ -x "$(command -v pip)" ]] || return 1
    # skip if click library is not installed
    [[ -n "$(pip show click 2> /dev/null)" ]] || return 1
    # passed all checks
    return 0
}

click_completion() {
    local completion_file="${zsh_comp_home}/${1}-complete.zsh"
    if out_of_date "${completion_file}"; then
        if click_enabled; then
            local click_variable=$(echo ${1} | tr '[:lower:]' '[:upper:]' | tr '-' '_')
            env "_${click_variable}_COMPLETE=zsh_source" "${1}" > "${completion_file}"
        fi
    fi
    if [[ -f $completion_file ]]; then
        source "${completion_file}"
    fi
}

cmd_completion() {
    local completion_file="${zsh_comp_home}/${1}-complete.zsh"
    if out_of_date "${completion_file}"; then
        if [[ -x "$(command -v $1)" ]]; then
            "$@" > "${completion_file}"
        fi
    fi
    if [[ -f $completion_file ]]; then
        source "${completion_file}"
    fi
}

click_completion "dkr"
click_completion "gd"
click_completion "git-remote"
click_completion "git-stats"
click_completion "llm"
click_completion "pr"

cmd_completion "uv" "generate-shell-completion" "zsh"
