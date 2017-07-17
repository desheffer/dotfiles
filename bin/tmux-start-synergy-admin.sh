#!/bin/sh
# https://mr-coffee.net/blog/setting-tmux-environment
session_name=tmux-start-synergy-session

tmux has-session -t $session_name
if [ $? != 0 ]; then
    tmux new-session -s $session_name -n server -d
    tmux send-keys -t $session_name 'echo "Do not forget to run this in the admin cygwin"'
    tmux send-keys -t $session_name 'echo "this is for the setup at home"'
    tmux send-keys -t $session_name 'synergyc 192.168.50.64' C-m

    #tmux split-window -h -t $session_name
    #tmux send-keys -t $session_name 'cd /home' C-m
    #tmux send-keys -t $session_name 'ls -la' C-m

    #tmux split-window -v -t $session_name
    #tmux send-keys -t $session_name 'cd /home' C-m
    #tmux send-keys -t $session_name 'python' C-m
fi

tmux a -t $session_name

#https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened
#!/bin/sh 
#tmux new-session -d 'vim'
#tmux split-window -v 'ipython'
#tmux split-window -h
#tmux new-window 'mutt'
#tmux -2 attach-session -d 
