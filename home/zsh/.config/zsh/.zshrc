[[ -n $SSH_CONNECTION ]] && stty -echo 2>/dev/null

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# shellcheck source=/dev/null
source "${ZINIT_HOME}/zinit.zsh"

source "$ZDOTDIR/rc.zsh"

if [[ -n $SSH_CONNECTION ]]; then
  _drain_terminal_responses() {
    add-zsh-hook -d precmd _drain_terminal_responses
    local _c
    while IFS= read -r -s -k 1 -t 0.05 _c 2>/dev/null; do :; done
  }
  add-zsh-hook precmd _drain_terminal_responses
fi
