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

# add completion executables
if [[ -x "$(command -v uv)" ]]; then
    eval "$(uv generate-shell-completion zsh)"
fi

# add completion files
opam_comp="${OPAMROOT}/opam-init/complete.zsh"
if [[ -f $opam_comp ]]; then
    source "${opam_comp}"
fi

click_enabled() {
    # skip if non-interactive
    [[ -o interactive ]] || return 1
    # skip if in tmux
    [[ -z $TMUX ]] || return 1
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
    # generate completions if they don't exist
    if [[ ! -f $completion_file ]]; then
        local click_variable=$(echo ${1} | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        eval "_${click_variable}_COMPLETE=zsh_source ${1} > ${completion_file}"
    fi
    source "${completion_file}"
}

if click_enabled; then
    click_completion "dkr"
    click_completion "gd"
    click_completion "git-remote"
    click_completion "git-stats"
    click_completion "llm"
    click_completion "pr"
fi
