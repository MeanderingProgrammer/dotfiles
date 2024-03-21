# Make scripts runnable without full path
export PATH="${HOME}/.config/shell/bin:$PATH"

# Add tab completion for click scripts
eval "$(_GD_COMPLETE=zsh_source gd)"
eval "$(_LLM_COMPLETE=zsh_source llm)"
eval "$(_PR_COMPLETE=zsh_source pr)"

# Add user bin folder to Path
export USER_BIN="${HOME}/bin"
[[ -d $USER_BIN ]] && export PATH="${USER_BIN}:$PATH"
