# ---- Skip if tmux is not installed ---- #
if [[ ! -x "$(command -v tmux)" ]]; then
    return
fi

# ---- Skip if some terminal is already attached ---- #
attached_sessions=$(tmux ls 2> /dev/null | grep attached)
if [[ ${#attached_sessions} != 0 ]]; then
    return
fi

start_new_session() {
    if [[ "$#" -ne 2 ]]; then
        echo "Usage $0: session_name command_name"
        return
    fi
    # Only create a new session if one isn't currently running
    existing_session=$(tmux ls 2> /dev/null | grep "$1")
    if [[ ${#existing_session} == 0 ]]; then
        tmux new -d -s "$1"
        tmux send-keys -t "$1" "$2" ENTER
    fi
}

start_new_session "main" "workspace"
start_new_session "notes" "notes"

# ---- Attach to main session ---- #
tmux attach -t "main"
