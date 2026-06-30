#!/usr/bin/env bash

tmuxname="ascheel-session"

function t () {
        # tmux has-session -t $tmuxname >/dev/null 2>&1
        # if [[ $? != 0 ]]; then
        #         tmux new-session -t $tmuxname
        # else
        #         tmux attach-session -d -t $tmuxname
        # fi

        tmux new-session -ADs $tmuxname
}
