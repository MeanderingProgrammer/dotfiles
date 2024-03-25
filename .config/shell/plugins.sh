export ZSH_HIGHLIGHT="zsh-syntax-highlighting"
export ZSH_HIGHLIGHT_INIT="$(brew --prefix)/share/$ZSH_HIGHLIGHT/$ZSH_HIGHLIGHT.zsh"
[[ -f $ZSH_HIGHLIGHT_INIT ]] && source "${ZSH_HIGHLIGHT_INIT}"
