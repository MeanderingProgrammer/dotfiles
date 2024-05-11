# ---- Environment Specific ---- #

system_type=$(uname -s)
services=()
if [[ "${system_type}" == "Darwin" ]]; then
    # Setup Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Add services only if we're not running in TMUX
    # This speeds up starting shells as brew services call takes ~1 second
    if [[ -z $TMUX ]]; then
        services+=("ollama")
    fi
elif [[ "${system_type}" == "Linux" ]]; then
    # Setup Homebrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # Building python with asdf: https://github.com/pyenv/pyenv/pull/2906
    export PYTHON_BUILD_USE_HOMEBREW=1
else
    echo "Unhandled system type ${system_type}, stopping setup"
    return
fi

# ---- Start Homebrew Services ---- #

for service in "${services[@]}"; do
    is_running=$(brew services list | grep "$service.*started")
    if [[ -z "$is_running" ]]; then
        brew services start $service
    fi
done

# ---- Language Home Cleanup ---- #

# Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# Opam
export OPAMROOT="${XDG_DATA_HOME}/opam"

# C#
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# Node
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

# Julia
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"

# ---- Language Setup ---- #

# ASDF
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_FORCE_PREPEND="yes"
asdf_src="$(brew --prefix asdf)/libexec/asdf.sh"
[[ -f $asdf_src ]] && source "${asdf_src}"

# Java
java_init="${ASDF_DATA_DIR}/plugins/java/set-java-home.zsh"
[[ -f $java_init ]] && source "${java_init}"

# Opam
opam_init="${OPAMROOT}/opam-init/init.zsh"
[[ -f $opam_init ]] && source "${opam_init}"

# C#
c_sharp_init="${ASDF_DATA_DIR}/plugins/dotnet-core/set-dotnet-home.zsh"
[[ -f $c_sharp_init ]] && source "${c_sharp_init}"

# ---- Software Home Cleanup ---- #

# AWS
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# GPG
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Less
export LESSHISTFILE="${XDG_STATE_HOME}/lesshst"

# Password Store
export PASSWORD_STORE_DIR="${HOME}/Documents/pass"

# Ansible
export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export ANSIBLE_REMOTE_TEMP="${ANSIBLE_HOME}/tmp"

# Matplotlib
export MPLCONFIGDIR="${XDG_CACHE_HOME}/matplotlib"

# ---- Software Setup ---- #

# The Fuck
eval $(thefuck --alias)

# Password Store
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# SSH
[[ -z $SSH_AUTH_SOCK ]] && eval "$(ssh-agent -s)"

# ---- PATH ---- #

# Add shell config bin folder
export PATH="${XDG_CONFIG_HOME}/shell/bin:$PATH"

# Add user bin folder
user_bin="${HOME}/bin"
[[ -d $user_bin ]] && export PATH="${user_bin}:$PATH"

# ---- Completions ---- #
zsh_cache_home="${XDG_CACHE_HOME}/zsh"
[[ ! -d $zsh_cache_home ]] && mkdir -p $zsh_cache_home

# Add completion directories
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
FPATH="$(rustc --print sysroot)/share/zsh/site-functions:${FPATH}"

# man zshcompsys
zstyle ':completion:*' cache-path "${zsh_cache_home}/compcache"
autoload -Uz compinit && compinit -d "${zsh_cache_home}/compdump"

completions_home="${XDG_DATA_HOME}/completions"
[[ ! -d $completions_home ]] && mkdir -p $completions_home

register_click_completion() {
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
zsh_suggest="zsh-autosuggestions"
zsh_suggest_init="$(brew --prefix)/share/$zsh_suggest/$zsh_suggest.zsh"
[[ -f $zsh_suggest_init ]] && source "${zsh_suggest_init}"

zsh_highlight="zsh-syntax-highlighting"
zsh_highlight_init="$(brew --prefix)/share/$zsh_highlight/$zsh_highlight.zsh"
[[ -f $zsh_highlight_init ]] && source "${zsh_highlight_init}"

# ---- Editor with Aliases ---- #

# Change default editor
export VISUAL="nvim"
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
bindkey "^[[B" history-search-forward
