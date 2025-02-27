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

click_completion() {
    [[ -x "$(command -v python)" ]] || return
    local completion_file="${zsh_comp_home}/${1}-complete.zsh"
    # Generate completions if they don't exist or we're outside of tmux
    if [[ ! -f $completion_file || -z $TMUX ]]; then
        click_variable=$(echo ${1} | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        eval "_${click_variable}_COMPLETE=zsh_source ${1} > ${completion_file}"
    fi
    source "${completion_file}"
}

# Add click scripts
click_completion "gd"
click_completion "git-remote"
click_completion "llm"
click_completion "pr"
