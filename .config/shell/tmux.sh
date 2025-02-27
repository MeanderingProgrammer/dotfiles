# ---- Skip if already in tmux ---- #
[[ -z $TMUX ]] || return

# ---- Skip if tmux is not installed ---- #
[[ -x "$(command -v tmux)" ]] || return

# ---- Skip if some terminal is already attached ---- #
attached_sessions=$(tmux ls 2> /dev/null | grep attached)
[[ -z $attached_sessions ]] || return

start_new_session() {
    # Ensure 2 arguments are provided and neither is empty
    [[ "${#}" == 2 && -n $1 && -n $2 ]] || return
    # Skip if a session with the same name is already running
    existing_session=$(tmux ls 2> /dev/null | grep "$1")
    [[ -z $existing_session ]] || return
    tmux new -d -s "$1"
    tmux send-keys -t "$1" "$2" ENTER
}

start_new_session "main" "workspace"
start_new_session "notes" "notes"

# ---- Attach to main session ---- #
tmux attach -t "main"
