zprofile() {
  # Auto start tmux in ssh.
  # [ -x "$(command -v fzf)"  ] && [[ -n "$SSH_CONNECTION" && -z $TMUX ]] && exec fzt

  if [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]] ; then
    [ -x "$(command -v fzf)"  ] && exec fzdm
  fi
}
