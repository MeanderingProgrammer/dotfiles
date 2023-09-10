# What gets displayed on line running command
PS1='%n@%m %~$ '

# Setup Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable Autocomplete
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit

# Change Default Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Set key bindings to emacs
bindkey -e

# Workspace Alias
alias workspace="cd ~/dev/repos"

# Advent Aliases
alias a_run="./scripts/advent.py run"
alias a_gen="./scripts/advent.py generate"

source ~/.shell/all.sh
