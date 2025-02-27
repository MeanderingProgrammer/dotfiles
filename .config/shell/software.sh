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

# ---- Home Cleanup ---- #

# Password Store
export PASSWORD_STORE_DIR="${HOME}/Documents/pass"

# Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Go
export GOPATH="${XDG_DATA_HOME}/go"
export GOBIN="${GOPATH}/bin"

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

# Matplotlib
export MPLCONFIGDIR="${XDG_CACHE_HOME}/matplotlib"

# ---- Path ---- #

# Go CLIs
export PATH="${GOBIN}:$PATH"

# Shared bin folder
export PATH="${XDG_CONFIG_HOME}/shell/bin:$PATH"

# User bin folder
export PATH="${HOME}/bin:$PATH"

# Prioritize Homebrew
[[ -n $HOMEBREW_PREFIX ]] && export PATH="${HOMEBREW_PREFIX}/bin:$PATH"

# System32 (WSL)
sys32_path="/mnt/c/Windows/System32"
if [[ -d $sys32_path ]]; then
    export PATH="$PATH:${sys32_path}"
    export PATH="$PATH:${sys32_path}/WindowsPowerShell/v1.0"
fi

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
