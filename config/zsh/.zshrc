source "$ZDOTDIR/zshrc" 2>/dev/null
source "$ZDOTDIR/zshenv" 2>/dev/null

# Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" 2>/dev/null
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" 2>/dev/null

# nvim configurations
source "$ZDOTDIR/nvim.zsh" 2>/dev/null

# lf configurations
source "$ZDOTDIR/lf.zsh" 2>/dev/null

# Git configurations 
source "$ZDOTDIR/git.zsh" 2>/dev/null

# Prompt setup.
hash-prompt() {
  autoload -U colors && colors

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
    
    PROMPT='%~>'
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

  prompt-length() {
    emulate -L zsh
      local -i x y="${#1}" m
      if (( y )); then
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
          x=y
          (( y *= 2 ))
        done
        while (( y > x + 1 )); do
          (( m = x + (y - x) / 2 ))
          (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
        done
      fi
    echo "$x"
  }

  fill-line() {
    local left_len="$(prompt-length "$1")"
    local right_len="$(prompt-length "$2")"
    local pad_len="$((COLUMNS - left_len - right_len - 1))"
    local pad="${(pl.$pad_len.. .)}"  # pad_len spaces
    echo "${1}${pad}${2}"
  }

  set-prompt() {
    local ret="$?"
    local top_left="%B%F{yellow}%n\
$(if [[ -n $SSH_CONNECTION ]]; then
  echo "%F{gray}@%F{blue}%M";
fi)\
$(if [[ -z $(git rev-parse --abbrev-ref HEAD 2>/dev/null) ]]; then
  echo '%F{gray} in %F{magenta}%~';
else
  echo "\
%F{gray} in repo: %F{yellow}%1~\
%F{gray} on %F{red}$(git rev-parse --abbrev-ref HEAD 2>/dev/null)";
# %F{gray}[%F{orange}$(git status --porcelain 2>/dev/null)%F{gray}]\
# %F{gray} at %F{blue}%~"
fi)"
    local top_right="%F{white}at %T"
    local bottom_left="$(if [ "$ret" = 0 ]; then
    echo "%F{cyan}$ ";
  else
    echo "%F{red}X ";
fi)%F{white}%b"
    local bottom_right=""

    PROMPT="$(fill-line "$top_left" "$top_right")"$'\n'$bottom_left
    RPROMPT="$bottom_right"
  }

  zle -N zle-line-init
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd set-prompt
}

automux() {
  input() {
    read name\?"Enter new session name: ";
    echo "$name";
  }

  session() {
    if [[ -n "$(tmux ls 2>/dev/null | grep -i "windows")" ]]; then
      fzf --layout=reverse --cycle <<< `echo "exit\nnew\n$(tmux ls)"` | awk '{print $1}';
    else
      echo "default";
    fi
  }

  case "$-" in
    *i*)
      if [ -z "$TMUX" ]; then
        local session="$(session)"
        case "$session" in
          "exit")    return;;
          "new")     exec tmux -u new -s "$(input)" ;;
          "default") exec tmux -u new -s "$session" ;;
          *)         exec tmux -u attach -t "$session" ;;
        esac
      else
        local session="$(session)"
        case "$session" in
          "exit") return;;
          "new")  name="$(input)"; tmux new -d -s "$name"; tmux -u switch -t "$name" ;;
          *)      tmux -u switch -t "$session" ;;
        esac
      fi 
    ;;
  esac
}

bindkey -s '^n' '^uautomux^m'

TMOUT=120
TRAPALRM() { pipes.sh } # { tock } # { cmatrix -s }

# Auto start tmux in ssh.
if [[ -n "$SSH_CONNECTION" ]] ; then
  automux
fi

if [[ -z "$DISPLAY" ]] ; then
  # Use the custom zsh prompt.
  setterm -blength 0
  set bell-style none

  autoload -Uz add-zsh-hook
  hash-prompt

  if [[ -z "$TMUX" ]]; then
    file="$(fzf --layout=reverse --cycle <<< `echo "$(\ls ~/.bin/xinit | sort)\ntmux\n$(tty)\npower off\nreboot\nsleep\nlogout"`)"

    if [[ -n "$file" ]]; then
      case "$file" in
        "logout") exit ;;
        "sleep") systemctl suspend && exit ;;
        "reboot") systemctl reboot ;;
        "power off") systemctl poweroff ;;
        "$(tty)") \clear ;;
        "tmux") exec automux ;;
        *) exec startx ~/.bin/xinit/"$file" ;;
      esac
    fi
  fi
else
  # Fetch machine's specs.
  neofetch

  # Use the starship prompt.
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"

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
    PROMPT='$(STARSHIP_CONFIG=~/.config/starship/config-transient.toml starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
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
fi
