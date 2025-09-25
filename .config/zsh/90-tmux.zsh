tmux_enabled() {
    # skip if non-interactive
    [[ -o interactive ]] || return 1
    # skip if in tmux
    [[ -z $TMUX ]] || return 1
    # skip if tmux is not installed
    [[ -x "$(command -v tmux)" ]] || return 1
    # skip if some terminal is already attached
    local attached_sessions=$(tmux ls 2> /dev/null | grep attached)
    [[ -z $attached_sessions ]] || return 1
    # passed all checks
    return 0
}

tmux_session() {
    # ensure 2 arguments are provided and neither is empty
    if [[ "${#}" != 2 || -z $1 || -z $2 ]]; then
        return
    fi
    # skip if a session with the same name is already running
    local existing_session=$(tmux ls 2> /dev/null | grep "$1")
    if [[ -n $existing_session ]]; then
        return
    fi
    tmux new -d -s "$1"
    tmux send-keys -t "$1" "$2" ENTER
}

if tmux_enabled; then
    tmux_session "main" "workspace"
    tmux_session "notes" "notes"

    # attach to main session
    tmux attach -t "main"
fi
