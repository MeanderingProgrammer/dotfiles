# ---- skip if already in tmux ---- #
[[ -z $TMUX ]] || return

# ---- skip if tmux is not installed ---- #
[[ -x "$(command -v tmux)" ]] || return

# ---- skip if some terminal is already attached ---- #
attached_sessions=$(tmux ls 2> /dev/null | grep attached)
[[ -z $attached_sessions ]] || return

start_new_session() {
    # ensure 2 arguments are provided and neither is empty
    [[ "${#}" == 2 && -n $1 && -n $2 ]] || return
    # skip if a session with the same name is already running
    existing_session=$(tmux ls 2> /dev/null | grep "$1")
    [[ -z $existing_session ]] || return
    tmux new -d -s "$1"
    tmux send-keys -t "$1" "$2" ENTER
}

start_new_session "main" "workspace"
start_new_session "notes" "notes"

# ---- attach to main session ---- #
tmux attach -t "main"
