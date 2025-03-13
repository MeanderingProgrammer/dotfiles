# ---- Completions ---- #

zsh_cache_home="${XDG_CACHE_HOME}/zsh"
[[ ! -d $zsh_cache_home ]] && mkdir -p $zsh_cache_home

# Add completion directories
[[ -n $HOMEBREW_PREFIX ]] && FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
[[ -x "$(command -v rustc)" ]] && FPATH="$(rustc --print sysroot)/share/zsh/site-functions:${FPATH}"

# man zshcompsys
zstyle ':completion:*' cache-path "${zsh_cache_home}/compcache"
autoload -Uz compinit && compinit -d "${zsh_cache_home}/compdump"

zsh_comp_home="${XDG_DATA_HOME}/completions"
[[ ! -d $zsh_comp_home ]] && mkdir -p $zsh_comp_home

check_python_env() {
    # Check if the result is already cached
    if [[ -n $PYTHON_ENV ]]; then
        return $PYTHON_ENV
    fi
    PYTHON_ENV=0
    [[ -x "$(command -v python)" ]] || PYTHON_ENV=1
    [[ -x "$(command -v pip)" ]] || PYTHON_ENV=1
    [[ -n "$(pip show click 2> /dev/null)" ]] || PYTHON_ENV=1
    return $PYTHON_ENV
}

click_completion() {
    local completion_file="${zsh_comp_home}/${1}-complete.zsh"
    # Generate completions if they don't exist or we're outside of tmux
    if [[ ! -f $completion_file || -z $TMUX ]]; then
        check_python_env || return
        local click_variable=$(echo ${1} | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        eval "_${click_variable}_COMPLETE=zsh_source ${1} > ${completion_file}"
    fi
    source "${completion_file}"
}

# Add click scripts
click_completion "gd"
click_completion "git-remote"
click_completion "llm"
click_completion "pr"
