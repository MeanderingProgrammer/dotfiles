# ---- editor ---- #

if has "nvim"; then
    # defaults
    export EDITOR="$(which nvim)"
    export MANPAGER="nvim +Man!"
fi

if [[ -n "${EDITOR}" ]]; then
    # related settings
    export VISUAL="${EDITOR}"
    export SUDO_EDITOR="${EDITOR}"

    # common commands
    alias n='$EDITOR .'
    alias v='$EDITOR .'
fi
