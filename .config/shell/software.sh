# ---- homebrew ---- #

init_homebrew() {
    local brew_init=""
    local brew_services=()
    local system_type=$(uname -s)
    if [[ "${system_type}" == "Darwin" ]]; then
        brew_init="/opt/homebrew/bin/brew"
        brew_services+=("ollama" "postgresql@17")
    elif [[ "${system_type}" == "Linux" ]]; then
        brew_init="/home/linuxbrew/.linuxbrew/bin/brew"
    else
        echo "unhandled system type: ${system_type}"
    fi
    # setup homebrew
    [[ -x $brew_init ]] && eval "$($brew_init shellenv)"
    # start services
    [[ "${#brew_services[@]}" == 0 ]] && return
    local services=$(brew services list)
    for service in "${brew_services[@]}"; do
        local running=$(echo ${services} | grep "$service.*started")
        [[ -z $running ]] && brew services start $service
    done
}

[[ -z $HOMEBREW_PREFIX ]] && init_homebrew

# ---- configure ---- #

# aws
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# c sharp
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# go
export GOPATH="${XDG_DATA_HOME}/go"
export GOBIN="${GOPATH}/bin"

# gpg
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# julia
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"

# less
export LESSHISTFILE="${XDG_STATE_HOME}/lesshst"

# matplotlib
export MPLCONFIGDIR="${XDG_CACHE_HOME}/matplotlib"

# node
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"

# opam
export OPAMROOT="${XDG_DATA_HOME}/opam"
opam_init="${OPAMROOT}/opam-init/init.zsh"
[[ -f $opam_init ]] && source "${opam_init}"

# password store
export PASSWORD_STORE_DIR="${HOME}/Documents/pass"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# postgresql
export PSQL_HISTORY="${XDG_STATE_HOME}/psql_history"

# python
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"

# ruby
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"

# rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# wsl
export SYSTEM_32="/mnt/c/Windows/System32"

# ---- path ---- #

# prepend go bin
export PATH="${GOBIN}:$PATH"

# prepend mason bin
export PATH="${XDG_DATA_HOME}/nvim/mason/bin:$PATH"

# prepend shell bin
export PATH="${XDG_CONFIG_HOME}/shell/bin:$PATH"

# prepend user bin
export PATH="${HOME}/bin:$PATH"

# prepend homebrew bins (highest priority)
if [[ -n $HOMEBREW_PREFIX ]]; then
    export PATH="${HOMEBREW_PREFIX}/opt/sqlite/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/bin:$PATH"
fi

# append system32 bins (lowest priority)
if [[ -d $SYSTEM_32 ]]; then
    export PATH="$PATH:${SYSTEM_32}"
    export PATH="$PATH:${SYSTEM_32}/WindowsPowerShell/v1.0"
fi

# ---- init ---- #

# fzf
[[ -x "$(command -v fzf)" ]] && eval "$(fzf --zsh)"

# mise
[[ -x "$(command -v mise)" ]] && eval "$(mise activate zsh)"

# ssh
[[ -z $SSH_AUTH_SOCK ]] && eval "$(ssh-agent -s)"
