# ---- commands ---- #

f() {
    fzf --cycle --preview 'fzf-preview.sh {}'
}

vim() {
    if [[ "${#}" -eq 0 ]]; then
        nvim
    elif [[ "${#}" -eq 1 ]]; then
        if [[ -d "${1}" ]]; then
            cd "${1}" && nvim .
        elif [[ -f "${1}" ]]; then
            nvim "${1}"
        else
            echo "neither a file nor a directory: ${1}"
        fi
    else
        echo "usage: <path>?"
    fi
}
