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
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
