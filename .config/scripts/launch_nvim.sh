#!/bin/bash

SESSIONNAME=$1
tmux has-session -t $SESSIONNAME &>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESSIONNAME 'nvim .'
    tmux rename-window $SESSIONNAME
    tmux select-window -t $SESSIONNAME:0
    tmux split-window -v
    tmux resize-pane -D 10
    tmux select-pane -U
fi

tmux attach -t $SESSIONNAME
