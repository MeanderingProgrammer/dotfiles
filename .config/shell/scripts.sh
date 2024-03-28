# Make scripts runnable without full path
export PATH="${HOME}/.config/shell/bin:$PATH"

# Add user bin folder to Path
export USER_BIN="${HOME}/bin"
[[ -d $USER_BIN ]] && export PATH="${USER_BIN}:$PATH"

# Add general tab completion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

export ZSH_COMPLETE="zsh-autocomplete"
export ZSH_COMPLETE_INIT="$(brew --prefix)/share/$ZSH_COMPLETE/$ZSH_COMPLETE.plugin.zsh"
[[ -f $ZSH_COMPLETE_INIT ]] && source "${ZSH_COMPLETE_INIT}"

export ZSH_HIGHLIGHT="zsh-syntax-highlighting"
export ZSH_HIGHLIGHT_INIT="$(brew --prefix)/share/$ZSH_HIGHLIGHT/$ZSH_HIGHLIGHT.zsh"
[[ -f $ZSH_HIGHLIGHT_INIT ]] && source "${ZSH_HIGHLIGHT_INIT}"

# Add tab completion for click scripts
eval "$(_GD_COMPLETE=zsh_source gd)"
eval "$(_LLM_COMPLETE=zsh_source llm)"
eval "$(_PR_COMPLETE=zsh_source pr)"
