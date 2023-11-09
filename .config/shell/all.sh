source ~/.config/shell/aliases.sh
source ~/.config/shell/editor.sh
source ~/.config/shell/software.sh

# Make scripts runnable without full path
export PATH="${HOME}/.config/shell/bin:$PATH"

# Add user bin folder to Path
export USER_BIN="${HOME}/bin"
[[ -d $USER_BIN ]] && export PATH="${USER_BIN}:$PATH"

# Only run if we're not already in a TMUX shell
[[ -z $TMUX ]] && source ~/.config/shell/tmux.sh
