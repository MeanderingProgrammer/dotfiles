# ---- VIM Mode and Keybindings ---- #

# Use vi mode explicitly
bindkey -v

# Fix vi mode search behavior for <esc>+/
vi-search-fix() {
    zle vi-cmd-mode
    zle .vi-history-search-backward
}
zle -N vi-search-fix

# For all valid escape sequences: man zshzle
bindkey -M viins "\e/" vi-search-fix

# Fix ability to delete characters
bindkey "^?" backward-delete-char

# Prefix based search
bindkey "^[[A" history-search-backward
bindkey "^[OA" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[OB" history-search-forward
