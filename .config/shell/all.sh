# ---- Common setup ---- #
shell_home="${XDG_CONFIG_HOME}/shell"

source "${shell_home}/aliases.sh"
source "${shell_home}/software.sh"

# ---- Computer specific setup ---- #
custom_shell="${shell_home}/custom.sh"
[[ -f $custom_shell ]] && source "${custom_shell}"

# ---- Only run if not already in TMUX ---- #
[[ -z $TMUX ]] && source "${shell_home}/tmux.sh"
