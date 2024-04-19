# ---- Main setup ---- #
source ~/.config/shell/aliases.sh
source ~/.config/shell/software.sh

# ---- Only run if not already in TMUX ---- #
[[ -z $TMUX ]] && source ~/.config/shell/tmux.sh
