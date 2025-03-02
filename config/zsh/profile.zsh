if [[ -n "$SSH_CONNECTION" && -z $TMUX ]]; then
    # Auto start tmux in ssh.
    [ -x "$(command -v fzf)" ] && exec fzt
elif [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]]; then
    # Simple display manager.
    [ -x "$(command -v fzf)" ] && exec fzdm
fi
