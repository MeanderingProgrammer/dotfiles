source ~/.config/shell/aliases.sh
source ~/.config/shell/software.sh

# Load scripts / plugins before editor is configured
source ~/.config/shell/scripts.sh

# Must run after main software loading
source ~/.config/shell/editor.sh

# Only run if we're not already in a TMUX shell
[[ -z $TMUX ]] && source ~/.config/shell/tmux.sh
