# ---- editor with aliases ---- #

# change default editor
export VISUAL="$(which nvim)"
export EDITOR="$VISUAL"

# aliases common editor commands
alias n='$VISUAL .'
alias v='$VISUAL .'

vim() {
    if [[ "${#}" -eq 0 ]]; then
        nvim
    elif [[ "${#}" -eq 1 ]]; then
        if [[ -d $1 ]]; then
            cd "${1}" && nvim .
        elif [[ -f $1 ]]; then
            nvim "${1}"
        else
            echo "${1} is neither a file nor a directory"
        fi
    else
        echo "usage: <path>?"
    fi
}
