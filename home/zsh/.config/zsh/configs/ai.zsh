ai() {
  local cmd
  cmd=$(aichat --execute "Write a single zsh shell command to: $*. Output ONLY the command, no explanation.")
  echo "→ $cmd"
  echo -n "Run it? [y/N] "
  read -r ans
  [[ $ans == y ]] && eval "$cmd"
}

_ai_complete_buffer() {
  if [[ -n "$BUFFER" ]]; then
    local _old="Convert this natural language to a zsh command. Output ONLY the command: $BUFFER"
    BUFFER+=" ⌛"
    zle -I && zle redisplay
    BUFFER=$(aichat -e "$_old")
    # export CURSOR=${#BUFFER}
    zle end-of-line
  fi
}

zle -N _ai_complete_buffer
bindkey "^\\" _ai_complete_buffer
