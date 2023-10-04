main_session="main"
notes_session="notes"

# Don't do anything if some terminal is already attached
attached_sessions=$(tmux ls | grep attached)
if [[ ${#attached_sessions} != 0 ]]; then
    return
fi

# Only create a new main session if one isn't currently running
existing_main_session=$(tmux ls | grep ${main_session})
if [[ ${#existing_main_session} == 0 ]]; then
    tmux new -d -s ${main_session}
    tmux send-keys -t ${main_session} "workspace" ENTER
fi

# Only create a new notes session if one isn't currently running
existing_notes_session=$(tmux ls | grep ${notes_session})
if [[ ${#existing_notes_session} == 0 ]]; then
    tmux new -d -s ${notes_session}
    tmux send-keys -t ${notes_session} "notes && vim ." ENTER
fi

# Attach to the main session
tmux attach -t ${main_session}
