[[ -n $SSH_CONNECTION ]] && stty -echo 2>/dev/null

source "$ZDOTDIR/rc.zsh"

if [[ -n $SSH_CONNECTION ]]; then
  _drain_terminal_responses() {
    add-zsh-hook -d precmd _drain_terminal_responses
    local _c
    while IFS= read -r -s -k 1 -t 0.05 _c 2>/dev/null; do :; done
  }
  add-zsh-hook precmd _drain_terminal_responses
fi
