# ---- plugins ---- #

load_zsh_plugin() {
    local plugin_init="$HOMEBREW_PREFIX/share/${1}/${1}.zsh"
    [[ -f $plugin_init ]] && source "${plugin_init}"
}

load_zsh_plugin "zsh-autosuggestions"
load_zsh_plugin "zsh-syntax-highlighting"
