if [ ! -x "$(command -v starship)" ]; then
  return
fi

export STARSHIP_CONFIG="$DOTFILES/home/starship/.config/starship/starship.toml"
eval "$(starship init zsh)"

zle-keymap-select() {
  starship_zle-keymap-select
  _cursor_by_keymap
}
zle -N zle-keymap-select

zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  # shellcheck disable=SC2016
  PROMPT='$(STARSHIP_CONFIG="$DOTFILES/home/starship/.config/starship/transient.toml" starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if ((ret)); then
    zle .send-break
  else
    zle .accept-line
  fi
  return "$ret"
}

zle -N zle-line-init
