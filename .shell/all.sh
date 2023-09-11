source ~/.shell/aliases.sh
source ~/.shell/git.sh
source ~/.shell/software.sh

# Make scripts runnable without full path
PATH=~/.shell/bin:$PATH

# Only run if we're not already in a TMUX shell
[[ -z $TMUX ]] && source ~/.shell/tmux.sh
