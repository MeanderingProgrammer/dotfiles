# What gets displayed on line running command
PS1='%n@%m %~$ '

# Change Default Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Set key bindings to emacs
bindkey -e

# Advent Aliases
alias a_run="./scripts/advent.py run"
alias a_gen="./scripts/advent.py generate"

source ~/.shell/all.sh
