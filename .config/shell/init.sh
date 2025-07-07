# ---- source all configurations ---- #

run_source() {
    local source_file="${XDG_CONFIG_HOME}/shell/${1}"
    [[ -f $source_file ]] && source "${source_file}"
}

run_source "00-aliases.sh"
run_source "10-software.sh"
run_source "20-completion.sh"
run_source "30-plugin.sh"
run_source "40-editor.sh"
run_source "50-commands.sh"
run_source "60-keybind.sh"
run_source "70-custom.sh"
run_source "90-tmux.sh"
