# Run environment specific configuration
system_type=$(uname -s)
if [[ "${system_type}" == "Darwin" ]]; then
    # Setup Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Setup SSH
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    # Start ollama
    brew services start ollama
elif [[ "${system_type}" == "Linux" ]]; then
    # Setup Homebrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # Setup SSH
    eval "$(ssh-agent -s)"
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

# Setup opam
export OPAM_INIT="${HOME}/.opam/opam-init/init.zsh"
[[ -r $OPAM_INIT ]] && source "${OPAM_INIT}"

# Setup Airflow
export AIRFLOW_DIR="$HOME/airflow"
[[ -d $AIRFLOW_DIR ]] && export AIRFLOW_HOME=$AIRFLOW_DIR
