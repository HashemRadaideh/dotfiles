if [[ -n $SSH_CONNECTION && -z $TMUX ]]; then
  command -v fzt &>/dev/null && fzt
fi

if [[ -z $DISPLAY && -z $WAYLAND_DISPLAY && $(tty) == /dev/tty1 ]]; then
  command -v fzdm &>/dev/null && fzdm
fi
