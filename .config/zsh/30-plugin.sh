# ---- plugins ---- #

zsh_plugin_load() {
    local plugin_init="$HOMEBREW_PREFIX/share/${1}/${1}.zsh"
    if [[ -f $plugin_init ]]; then
        source "${plugin_init}"
    fi
}

zsh_plugin_load "zsh-autosuggestions"
zsh_plugin_load "zsh-syntax-highlighting"
