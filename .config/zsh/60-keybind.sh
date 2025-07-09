# ---- vim mode and keybindings ---- #

# use vi mode explicitly
bindkey -v

# fix vi mode search behavior for <esc>+/
vi-search-fix() {
    zle vi-cmd-mode
    zle .vi-history-search-backward
}
zle -N vi-search-fix

# for all valid escape sequences: man zshzle
bindkey -M viins "\e/" vi-search-fix

# fix ability to delete characters
bindkey "^?" backward-delete-char

# prefix based search
bindkey "^[[A" history-search-backward
bindkey "^[OA" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[OB" history-search-forward
