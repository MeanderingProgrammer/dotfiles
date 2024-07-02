# ---- Common setup ---- #
source "${XDG_CONFIG_HOME}/shell/aliases.sh"
source "${XDG_CONFIG_HOME}/shell/software.sh"

# ---- Computer specific setup ---- #
custom_shell="${XDG_CONFIG_HOME}/shell/custom.sh"
[[ -f $custom_shell ]] && source "${custom_shell}"

# ---- Only run if not already in TMUX ---- #
[[ -z $TMUX ]] && source "${XDG_CONFIG_HOME}/shell/tmux.sh"
