if [ ! -x "$(command -v starship)"  ]; then
    return
fi

# Use the starship prompt.
export STARSHIP_CONFIG="$DOTFILES/config/starship/starship.toml"
eval "$(starship init zsh)"

# Fix recursion issue: Wrap starship's keymap-select function with recursion guard
# Store original function BEFORE modifying it
local starship_orig_func=""
if (( ${+functions[starship_zle-keymap-select-wrapped]} )); then
    starship_orig_func=$(functions starship_zle-keymap-select-wrapped 2>/dev/null)
fi

# Cursor setting function
starship_set_cursor() {
    case "$KEYMAP" in
        vicmd) echo -ne '\e[1 q' ;;
        viins|main) echo -ne '\e[5 q' ;;
    esac
}

# Wrap starship's function with recursion guard and cursor handling
if [[ -n "$starship_orig_func" ]]; then
    # Extract function body
    local starship_body
    starship_body="${starship_orig_func#starship_zle-keymap-select-wrapped}"
    starship_body="${starship_body#*\{}"
    starship_body="${starship_body%\}}"

    # Create wrapped version with recursion guard
    eval "starship_zle-keymap-select-wrapped() {
        # Prevent recursion - if already running, skip
        [[ -n \"\$_starship_km_running\" ]] && return
        _starship_km_running=1

        # Execute original starship code (updates prompt with keymap info)
        $starship_body

        # Set cursor shape based on keymap
        case \"\$KEYMAP\" in
            vicmd) echo -ne '\e[1 q' ;;
            viins|main) echo -ne '\e[5 q' ;;
        esac

        # Clear guard
        _starship_km_running=
    }"
fi

# Also set cursor via precmd hook as backup (runs before prompt)
autoload -Uz add-zsh-hook
add-zsh-hook precmd starship_set_cursor

# Combined zle-line-init: handles both vi mode cursor and transient prompt
# Note: cursor shape is handled by precmd hook above, not here, to avoid recursion
zle-line-init() {
  emulate -L zsh

  # Set vi insert mode (cursor shape handled by precmd hook)
  zle -K viins

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='$(STARSHIP_CONFIG="$DOTFILES/config/starship/transient.toml" starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init
