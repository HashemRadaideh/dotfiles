_TMUX_ZSH_PID=$$
_TMUX_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/tmux"

if [[ -n "$TMUX_PANE" ]]; then
  _TMUX_PANE_KEY=$(tmux display-message -p '#{session_name}_w#{window_index}_p#{pane_index}' 2>/dev/null)
else
  _TMUX_PANE_KEY=""
fi

_tmux_preexec_save() {
  [[ -z "$_TMUX_PANE_KEY" ]] && return
  mkdir -p "$_TMUX_CACHE"
  printf '%s\n%s\n' "$1" "$_TMUX_ZSH_PID" >"$_TMUX_CACHE/$_TMUX_PANE_KEY"
}

_tmux_precmd_hint() {
  [[ -z "$_TMUX_PANE_KEY" ]] && return
  local cmd_file="$_TMUX_CACHE/$_TMUX_PANE_KEY"
  [[ -f "$cmd_file" ]] || return
  local last_cmd saved_pid
  {
    read -r last_cmd
    read -r saved_pid
  } <"$cmd_file"
  [[ "$saved_pid" == "$_TMUX_ZSH_PID" ]] && return
  command rm -f "$cmd_file"
  print -P "%F{yellow}↺ Last command: %F{cyan}${last_cmd}%f"
  # eval "$last_cmd"
}

sync_display_from_tmux() {
  [[ -n "$TMUX" ]] || return 0

  if [[ -n "$DISPLAY" && "$_LAST_DISPLAY" != "$DISPLAY" ]]; then
    if ! xdpyinfo >/dev/null 2>&1; then
      local new_display
      new_display=$(tmux show-environment DISPLAY 2>/dev/null | cut -d= -f2)
      [[ -n "$new_display" ]] && export DISPLAY="$new_display"
    fi
    _LAST_DISPLAY="$DISPLAY"
  fi
}

# add-zsh-hook preexec _tmux_preexec_save
# add-zsh-hook precmd _tmux_precmd_hint
add-zsh-hook precmd sync_display_from_tmux
