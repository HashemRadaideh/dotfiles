bindkey -v
export KEYTIMEOUT=1

_cursor_block() { printf '\e[1 q'; }
_cursor_beam() { printf '\e[5 q'; }
_cursor_by_keymap() { if [[ "$KEYMAP" == vicmd ]]; then _cursor_block; else _cursor_beam; fi; }
zle -N zle-keymap-select _cursor_by_keymap

_cursor_beam

# autoload -Uz add-zle-hook-widget
# _cursor_line_init() {
#   zle -K viins
#   _cursor_beam
# }
# add-zle-hook-widget -Uz zle-line-init _cursor_line_init

vi-yank-clipboard() {
  zle vi-yank
  if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    echo "$CUTBUFFER" | xclip -sel c
  else
    echo "$CUTBUFFER" | wl-copy
  fi
}
zle -N vi-yank-clipboard

bindkey -M vicmd 'y' vi-yank-clipboard

autoload edit-command-line
zle -N edit-command-line

bindkey -M vicmd e edit-command-line
bindkey -M viins '^e' edit-command-line

typeset -g -A key

# shellcheck disable=SC2154
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key["Control-Left"]="${terminfo[kLFT5]}"
key["Control-Right"]="${terminfo[kRIT5]}"
key[Insert]="${terminfo[kich1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key["Shift-Tab"]="${terminfo[kcbt]}"

[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char
[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line
[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-history
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-history
[[ -n "${key[Left]}" ]] && bindkey -- "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey -- "${key[Right]}" forward-char
[[ -n "${key["Control-Left"]}" ]] && bindkey -- "${key["Control-Left"]}" backward-word
[[ -n "${key["Control-Right"]}" ]] && bindkey -- "${key["Control-Right"]}" forward-word
[[ -n "${key[Insert]}" ]] && bindkey -- "${key[Insert]}" overwrite-mode
[[ -n "${key[PageUp]}" ]] && bindkey -- "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey -- "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key["Shift-Tab"]}" ]] && bindkey -- "${key["Shift-Tab"]}" reverse-menu-complete

if ((${+terminfo[smkx]} && ${+terminfo[rmkx]})); then
  autoload -Uz add-zle-hook-widget
  zle_application_mode_start() { echoti smkx; }
  zle_application_mode_stop() { echoti rmkx; }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

bindkey -M viins '^H' backward-kill-word

bindkey -M viins '^[[3;5~' kill-word

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

bindkey '^z' undo
bindkey '^y' redo
bindkey ' ' magic-space

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
