# What gets displayed on line running command
PS1='%n@%m %~$ '

# Change Default Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Set key bindings to emacs
bindkey -e

# Run all general shell setup
source ~/.shell/all.sh
