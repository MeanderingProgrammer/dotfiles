# ---- homebrew ---- #

homebrew_init() {
    local brew_mac="/opt/homebrew/bin/brew"
    local brew_linux="/home/linuxbrew/.linuxbrew/bin/brew"
    local brew_services=()
    # init
    if [[ -x ${brew_mac} ]]; then
        eval "$($brew_mac shellenv)"
        brew_services+=("ollama" "postgresql@17")
    elif [[ -x ${brew_linux} ]]; then
        eval "$($brew_linux shellenv)"
    fi
    # start services
    if [[ "${#brew_services[@]}" == 0 ]]; then
        return
    fi
    local services=$(brew services list)
    for service in "${brew_services[@]}"; do
        local running=$(echo ${services} | grep "$service.*started")
        if [[ -z $running ]]; then
            brew services start $service
        fi
    done
}

if [[ -z $HOMEBREW_PREFIX ]]; then
    homebrew_init
fi

# ---- languages ---- #

# c sharp
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# go
export GOPATH="${XDG_DATA_HOME}/go"
export GOBIN="${GOPATH}/bin"

# gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# julia
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"

# node
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"

# opam
export OPAMROOT="${XDG_DATA_HOME}/opam"
opam_init="${OPAMROOT}/opam-init/init.zsh"
if [[ -f $opam_init ]]; then
    source "${opam_init}"
fi

# python
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"

# ruby
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"

# rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# ---- tools ---- #

# aws
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# gpg
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# less
export LESSHISTFILE="${XDG_STATE_HOME}/lesshst"

# mason
export MASON_HOME="${XDG_DATA_HOME}/nvim/mason"

# matplotlib
export MPLCONFIGDIR="${XDG_CACHE_HOME}/matplotlib"

# password store
export PASSWORD_STORE_DIR="${HOME}/Documents/pass"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# postgresql
export PSQL_HISTORY="${XDG_STATE_HOME}/psql_history"

# wsl
export SYSTEM_32="/mnt/c/Windows/System32"

# ---- path ---- #

# prepend go bin
export PATH="${GOBIN}:$PATH"

# prepend mason bin
export PATH="${MASON_HOME}/bin:$PATH"

# prepend config bin
export PATH="${XDG_CONFIG_HOME}/bin:$PATH"

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

if [[ $(ulimit -n) -lt 8192 ]]; then
    ulimit -n 8192
fi

# fzf
if [[ -x "$(command -v fzf)" ]]; then
    eval "$(fzf --zsh)"
fi

# mise
if [[ -x "$(command -v mise)" ]]; then
    eval "$(mise activate zsh)"
fi

# ssh
if [[ -z $SSH_AUTH_SOCK ]]; then
    eval "$(ssh-agent -s)"
fi
