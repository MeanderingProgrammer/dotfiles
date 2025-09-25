if [[ ! -o interactive ]]; then
    return
fi

# ----  completions   ---- #
# ---- man zshcompsys ---- #
zsh_cache_home="${XDG_CACHE_HOME}/zsh"
safe_directory "${zsh_cache_home}"

zsh_comp_home="${XDG_DATA_HOME}/completions"
safe_directory "${zsh_comp_home}"

# add completion directories
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
    FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi
if has "rustc"; then
    FPATH="$(rustc --print sysroot)/share/zsh/site-functions:${FPATH}"
fi

zstyle ':completion:*' cache-path "${zsh_cache_home}/compcache"
autoload -Uz compinit && compinit -d "${zsh_cache_home}/compdump"

# add completion files
safe_source "${OPAMROOT}/opam-init/complete.zsh"

# update generated completions weekly
out_of_date() {
    [[ ! -f "${1}" ]] && return 0
    local current=$(date +%s)
    local modified=$(date -r "${1}" +%s)
    (( current - modified >= 604800 ))
}

click_enabled() {
    # skip if python or pip is not installed
    has "python" && has "pip" || return 1
    # skip if click library is not installed
    [[ -n "$(pip show click 2> /dev/null)" ]] || return 1
    # passed all checks
    return 0
}

click_completion() {
    local completion_file="${zsh_comp_home}/${1}-complete.zsh"
    if out_of_date "${completion_file}" && click_enabled; then
        local click_variable=$(echo "${1}" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        env "_${click_variable}_COMPLETE=zsh_source" "${1}" > "${completion_file}"
    fi
    safe_source "${completion_file}"
}

cmd_completion() {
    local completion_file="${zsh_comp_home}/${1}-complete.zsh"
    if out_of_date "${completion_file}" && has "${1}"; then
        "$@" > "${completion_file}"
    fi
    safe_source "${completion_file}"
}

click_completion "dkr"
click_completion "gd"
click_completion "git-remote"
click_completion "git-stats"
click_completion "llm"
click_completion "pr"

cmd_completion "uv" "generate-shell-completion" "zsh"
