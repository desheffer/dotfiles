#!/bin/sh

session_name=build-and-release-session

tmux has-session -t $session_name
if [ $? != 0 ]; then
    tmux new-session -s $session_name -n server -d
    tmux send-keys -t $session_name 'cd ~/code/weedmaps/core' C-m
    tmux send-keys -t $session_name 'helpWeedmaps' C-m
    #tmux send-keys -t $session_name 'vim' C-m

    tmux split-window -h -t $session_name
    tmux send-keys -t $session_name 'cd ~/code/weedmaps/ionic' C-m
    tmux send-keys -t $session_name 'helpWeedmaps' C-m

    tmux split-window -v -t $session_name
    tmux send-keys -t $session_name 'cd ~/code/weedmaps/api' C-m
    tmux send-keys -t $session_name 'helpWeedmaps' C-m
    #tmux send-keys -t $session_name 'python' C-m
fi

tmux a -t $session_name
