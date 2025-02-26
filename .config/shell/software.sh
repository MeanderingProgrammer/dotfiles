# ---- Homebrew ---- #

if [[ -z $HOMEBREW_PREFIX ]]; then
    services=()
    system_type=$(uname -s)
    if [[ "${system_type}" == "Darwin" ]]; then
        brew_path="/opt/homebrew/bin/brew"
        # Add services
        services+=("ollama")
    elif [[ "${system_type}" == "Linux" ]]; then
        brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
    else
        echo "Unhandled system type ${system_type}, stopping setup"
        return
    fi
    # Setup Homebrew
    [[ -x $brew_path ]] && eval "$($brew_path shellenv)"
    # Start Homebrew Services
    for service in "${services[@]}"; do
        is_running=$(brew services list | grep "$service.*started")
        if [[ -z "$is_running" ]]; then
            brew services start $service
        fi
    done
fi

# ---- Path ---- #

prepend_path() {
    # Ensure 2 arguments are provided and neither is empty
    [[ "${#}" == 2 && -n $1 && -n $2 ]] || return
    path_value="${1}/${2}"
    [[ -d $path_value ]] && export PATH="${path_value}:$PATH"
}

# Shared bin folder
prepend_path "$XDG_CONFIG_HOME" "shell/bin"

# User bin folder
prepend_path "$HOME" "bin"

# Prioritize Homebrew
prepend_path "$HOMEBREW_PREFIX" "bin"

# System32 (WSL)
sys32_path="/mnt/c/Windows/System32"
if [[ -d $sys32_path ]]; then
    export PATH="$PATH:${sys32_path}"
    export PATH="$PATH:${sys32_path}/WindowsPowerShell/v1.0"
fi

# ---- Home Cleanup ---- #

# Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Go
export GOPATH="${XDG_DATA_HOME}/go"

# Python
export PYTHON_HISTORY="${XDG_DATA_HOME}/python_history"

# Node
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

# Opam
export OPAMROOT="${XDG_DATA_HOME}/opam"

# Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# C#
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# Julia
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"

# AWS
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# GPG
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Less
export LESSHISTFILE="${XDG_STATE_HOME}/lesshst"

# Password Store
export PASSWORD_STORE_DIR="${HOME}/Documents/pass"

# Matplotlib
export MPLCONFIGDIR="${XDG_CACHE_HOME}/matplotlib"

# ---- Language Setup ---- #

# Mise
[[ -x "$(command -v mise)" ]] && eval "$(mise activate zsh)"

# Opam
opam_init="${OPAMROOT}/opam-init/init.zsh"
[[ -f $opam_init ]] && source "${opam_init}"

# ---- Software Setup ---- #

# Password Store
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# SSH
[[ -z $SSH_AUTH_SOCK ]] && eval "$(ssh-agent -s)"

# fzf
[[ -x "$(command -v fzf)" ]] && eval "$(fzf --zsh)"

# ---- Completions ---- #
zsh_cache_home="${XDG_CACHE_HOME}/zsh"
[[ ! -d $zsh_cache_home ]] && mkdir -p $zsh_cache_home

# Add completion directories
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
[[ -x "$(command -v rustc)" ]] && FPATH="$(rustc --print sysroot)/share/zsh/site-functions:${FPATH}"

# man zshcompsys
zstyle ':completion:*' cache-path "${zsh_cache_home}/compcache"
autoload -Uz compinit && compinit -d "${zsh_cache_home}/compdump"

completions_home="${XDG_DATA_HOME}/completions"
[[ ! -d $completions_home ]] && mkdir -p $completions_home

register_click_completion() {
    if [[ ! -x "$(command -v python)" ]]; then
        return
    fi
    completion_file="${completions_home}/${1}-complete.zsh"
    # Only re-generate completions outside of TMUX
    if [[ ! -f $completion_file || -z $TMUX ]]; then
        click_variable=$(echo ${1} | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        eval "_${click_variable}_COMPLETE=zsh_source ${1} > ${completion_file}"
    fi
    source "${completion_file}"
}

# Add click scripts
register_click_completion "gd"
register_click_completion "git-remote"
register_click_completion "llm"
register_click_completion "pr"

# ---- Plugins ---- #
load_zsh_plugin() {
    plugin_init="$HOMEBREW_PREFIX/share/${1}/${1}.zsh"
    [[ -f $plugin_init ]] && source "${plugin_init}"
}

load_zsh_plugin "zsh-autosuggestions"
load_zsh_plugin "zsh-syntax-highlighting"

# ---- Editor with Aliases ---- #

# Change default editor
export VISUAL="$(which nvim)"
export EDITOR="$VISUAL"

# Aliases common editor commands
alias n='$VISUAL .'
alias v='$VISUAL .'

vim() {
    if [[ "${#}" -eq 0 ]]; then
        nvim
    elif [[ "${#}" -eq 1 ]]; then
        if [[ -d $1 ]]; then
            cd "${1}" && nvim .
        elif [[ -f $1 ]]; then
            nvim "${1}"
        else
            echo "${1} is neither a file nor a directory"
        fi
    else
        echo "Usage: <path>?"
    fi
}

# ---- VIM Mode and Keybindings ---- #

# Use vi mode, set explicitly
bindkey -v
# Fix vi mode search behavior for <esc>+/
vi-search-fix() {
    zle vi-cmd-mode
    zle .vi-history-search-backward
}
zle -N vi-search-fix
# For all valid escape sequences: man zshzle
bindkey -M viins "\e/" vi-search-fix
# Fix ability to delete characters
bindkey "^?" backward-delete-char
# Prefix based search
bindkey "^[[A" history-search-backward
bindkey "^[OA" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[OB" history-search-forward
