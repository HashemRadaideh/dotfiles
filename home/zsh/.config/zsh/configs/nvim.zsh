export KEYTIMEOUT=1

vi-yank-clipboard() {
  zle vi-yank
  if [[ "$XDG_SESSION_TYPE" == x11 ]]; then
    echo "$CUTBUFFER" | xclip -sel c
  else
    echo "$CUTBUFFER" | wl-copy
  fi
}
zle -N vi-yank-clipboard

bindkey -M vicmd 'y' vi-yank-clipboard

autoload edit-command-line
zle -N edit-command-line

bindkey -M vicmd 'e' edit-command-line
bindkey -M viins '^e' edit-command-line

nvims() {
  local NVIMS_LIST="${XDG_CACHE_HOME:-$HOME/.cache}/nvims.list"
  [[ ! -f "$NVIMS_LIST" ]] && {
    mkdir -p "${NVIMS_LIST:h}"
    echo "default" >"$NVIMS_LIST"
  }

  local name
  name=$(fzf --prompt=" Neovim: " --print-query <"$NVIMS_LIST" | tail -1)
  [[ -z "$name" ]] && return 0

  grep -qxF "$name" "$NVIMS_LIST" ||
    echo "$name" >>"$NVIMS_LIST" &&
    sed -i "/^default$/d" "$NVIMS_LIST" &&
    echo "default" >>"$NVIMS_LIST"

  local appname=""
  [[ "$name" != "default" ]] && appname="nvim-$name"

  NVIM_APPNAME="$appname" nvim "$@"
}

nvims-rm() {
  local NVIMS_LIST="${XDG_CACHE_HOME:-$HOME/.cache}/nvims.list"
  [[ ! -f "$NVIMS_LIST" ]] && {
    mkdir -p "${NVIMS_LIST:h}"
    echo "default" >"$NVIMS_LIST"
  }

  local name
  name=$(command cat "$NVIMS_LIST" | fzf --prompt="󰗩 Remove  ") || return 0
  [[ -z "$name" ]] && return 0

  if [[ "$name" == "default" ]]; then
    rm -rf "${XDG_DATA_HOME:-$HOME/.local/share}/nvim" \
      "${XDG_STATE_HOME:-$HOME/.local/state}/nvim" \
      "${XDG_CACHE_HOME:-$HOME/.cache}/nvim"
  else
    rm -rf "${XDG_DATA_HOME:-$HOME/.local/share}/nvim-$name" \
      "${XDG_STATE_HOME:-$HOME/.local/state}/nvim-$name" \
      "${XDG_CACHE_HOME:-$HOME/.cache}/nvim-$name"
    sed -i "/^${name}$/d" "$NVIMS_LIST"
  fi
}

bindkey -s '^s' "^unvims^m"
bindkey -s '^a' "^unvim^m"
