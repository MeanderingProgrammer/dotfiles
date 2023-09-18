source ~/.config/shell/aliases.sh
source ~/.config/shell/editor.sh
source ~/.config/shell/software.sh

# Make scripts runnable without full path
PATH=~/.config/shell/bin:$PATH

# Only run if we're not already in a TMUX shell
[[ -z $TMUX ]] && source ~/.config/shell/tmux.sh
