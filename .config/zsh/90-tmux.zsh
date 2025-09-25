if [[ ! -o interactive ]]; then
    return
fi

tmux_enabled() {
    # skip if in tmux
    [[ -z "${TMUX}" ]] || return 1
    # skip if tmux is not installed
    has "tmux" || return 1
    # skip if some terminal is already attached
    local attached=$(tmux ls 2> /dev/null | grep attached)
    [[ -z "${attached}" ]] || return 1
    # passed all checks
    return 0
}

tmux_session() {
    # session with same name must not be running
    local existing=$(tmux ls 2> /dev/null | grep "${1}")
    if [[ -z "${existing}" ]]; then
        tmux new -d -s "${1}"
        tmux send-keys -t "${1}" "${2}" ENTER
    fi
}

if tmux_enabled; then
    tmux_session "main" "workspace"
    tmux_session "notes" "notes"

    # attach to main session
    tmux attach -t "main"
fi
