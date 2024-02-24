# Run environment specific configuration
system_type=$(uname -s)
if [[ "${system_type}" == "Darwin" ]]; then
    # Setup Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Start services
    services=("ollama" "libvirt")
    for service in "${services[@]}"; do
        is_running=$(brew services list | grep "$service.*started")
        if [[ -z "$is_running" ]]; then
            brew services start $service
        fi
    done
elif [[ "${system_type}" == "Linux" ]]; then
    # Setup Homebrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # Add System32 to PATH
    export PATH="$PATH:/mnt/c/Windows/System32"
    export PATH="$PATH:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"
else
    echo "Unhandled system type ${system_type}, stopping setup"
    return
fi

# Enable Autocomplete
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit

# Setup ASDF
export ASDF_FORCE_PREPEND="yes"
export ASDF_SRC="$(brew --prefix asdf)/libexec/asdf.sh"
[[ -f $ASDF_SRC ]] && source "${ASDF_SRC}"

# Setup Java
export JAVA_INIT="$HOME/.asdf/plugins/java/set-java-home.zsh"
[[ -r $JAVA_INIT ]] && source "${JAVA_INIT}"

# Setup opam
export OPAM_INIT="$HOME/.opam/opam-init/init.zsh"
[[ -r $OPAM_INIT ]] && source "${OPAM_INIT}"

# Setup C#
export C_SHARP_INIT="$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"
[[ -r $C_SHARP_INIT ]] && source "${C_SHARP_INIT}"

# Setup Airflow
export AIRFLOW_DIR="$HOME/airflow"
[[ -d $AIRFLOW_DIR ]] && export AIRFLOW_HOME=$AIRFLOW_DIR

# Setup Password Store Extensions
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
