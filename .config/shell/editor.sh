# Change default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Aliases common editor commands
alias n="$VISUAL ."
alias v="$VISUAL ."
alias vim="$VISUAL"

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
