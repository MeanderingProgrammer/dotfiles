# ---- Source all configurations ---- #

run_source() {
    local source_file="${XDG_CONFIG_HOME}/shell/${1}"
    [[ -f $source_file ]] && source "${source_file}"
}

run_source "aliases.sh"
run_source "software.sh"
run_source "completion.sh"
run_source "plugin.sh"
run_source "editor.sh"
run_source "editor.sh"
run_source "keybind.sh"
run_source "custom.sh"
run_source "tmux.sh"
