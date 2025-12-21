function fzt() {
    if [ -n "$(tmux ls 2>/dev/null)" ]; then
        session=$(
            tmux ls -F "#S" |
            fzf --prompt="Session: " --print-query |
            awk -v RS="\n" '
            NR==1 { sub1=$0 }
            NR==2 { sub2=$0 }
            END   { print index(sub2, sub1) ? sub2 : sub1 }'
        )
    else
        exec tmux -u new -s "default"
    fi

    [ -z "$session" ] && exit

    if tmux has -t "$session" 2>/dev/null; then
        if [ -z "$TMUX" ]; then
            exec tmux -u attach -t "$session"
        else
            tmux -u switch -t "$session"
        fi
    else
        if [ -z "$TMUX" ]; then
            exec tmux -u new -s "$session"
        else
            tmux new -d -s "$session" && tmux -u switch -t "$session"
        fi
    fi
}
