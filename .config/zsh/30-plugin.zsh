# ---- plugins ---- #

zsh_plugin_load() {
    if [[ -n "${HOMEBREW_PREFIX}" ]]; then
        safe_source "${HOMEBREW_PREFIX}/share/${1}/${1}.zsh"
    fi
}

zsh_plugin_load "zsh-autosuggestions"
zsh_plugin_load "zsh-syntax-highlighting"
