# Run environment specific configuration
system_type=$(uname -s)
if [[ "${system_type}" == "Darwin" ]]
then
    # Setup Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Workspace Alias
    alias workspace="cd ~/dev/repos"
    # Setup SSH
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
elif [[ "${system_type}" == "Linux" ]]
then
    # Setup Homebrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # Workspace Alias
    alias workspace="cd /mnt/c/Users/vsusl/Documents/scripts"
    # Setup SSH
    eval "$(ssh-agent -s)"
else
    echo "Unhandled system type ${system_type}, stopping setup"
    return
fi

# Enable Autocomplete
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit

# Setup ASDF
export ASDF_SRC="$(brew --prefix asdf)/libexec/asdf.sh"
[[ -f $ASDF_SRC ]] && source "${ASDF_SRC}"

# Setup Airflow
export AIRFLOW_DIR="$HOME/airflow"
[[ -d $AIRFLOW_DIR ]] && export AIRFLOW_HOME=$AIRFLOW_DIR
