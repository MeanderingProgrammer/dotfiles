# Use TMUX by default
tmux_session="main"

# Don't do anything if some terminal is already attached
attached_sessions=$(tmux ls | grep attached)
if [[ ${#attached_sessions} != 0 ]]; then
    return
fi

# Only create a new session if one isn't currently running
existing_session=$(tmux ls | grep ${tmux_session})
if [[ ${#existing_session} == 0 ]]; then
    tmux new-session -d -s ${tmux_session}
    tmux send-keys -t ${tmux_session} "workspace" ENTER
fi

# Attach to the session
tmux attach-session -t ${tmux_session}
