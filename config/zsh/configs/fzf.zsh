if [ ! -x "$(command -v fzf)"  ]; then
  return
fi

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export FZF_DEFAULT_OPTS='--height=~50% --layout=reverse --border --cycle --preview="bat --decorations=always --color=always {} 2>/dev/null" --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down --exit-0'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude .cache'

fzdm() {
  if [[ -z "$TMUX" ]]; then
    local list=("$(ls "$HOME/.bin/xinits" | sort)" "tmux" "$(tty)" "power off" "reboot" "sleep" "logout")
    local file=`printf "%s\n" "${list[@]}" | fzf --border-label=" Fuzzy Display Manager (fzdm) "`

    if [ -n "$file" ]; then
      case "$file" in
        "logout") exit ;;
        "sleep") systemctl suspend ;;
        "reboot") systemctl reboot ;;
        "power off") systemctl poweroff ;;
        "$(tty)") clear ;;
        "tmux") exec fzt ;;
        *) exec startx "$HOME/.bin/xinits/$file" ;;
      esac
    fi
  fi
}

fzt() {
  input() {
    read name\?"Enter new session name: ";
    echo "$name";
  }

  local session="exit"

  if [[ -n "$(tmux -u ls 2>/dev/null | grep -i "windows")" ]]; then
    local list=`echo "exit\nnew\n$(tmux -u ls)"`
    fzf --prompt="Session: " <<< "${list[@]}" | awk '{print $1}' | read -t 5 session
  else
    echo "default" | read -t 5 session
  fi

  if [ -z "$TMUX" ]; then
    case "$session" in
      "exit")    return;;
      "new")     exec tmux -u new -s "$(input)" ;;
      "default") exec tmux -u new -s "$session" ;;
      *)         exec tmux -u attach -t "$session" ;;
    esac
  else
    case "$session" in
      "exit") return;;
      "new")  name="$(input)"; tmux -u new -d -s "$name"; tmux -u switch -t "$name" ;;
      *)      tmux -u switch -t "$session" ;;
    esac
  fi
}

ff() {
  temp=`fzf --prompt='Edit:'`
  if [[ "$temp" == "." ]]; then
    cd
  fi

  if [[ -n "$temp" ]]; then
    if  [ -d "$temp" ]; then
      cd "$temp"
    else
      cd "$(sed 's/\(.*\)\/.*/\1/' <<< "$temp")" && "$EDITOR" "$(sed 's/.*\/\(.*\)/\1/' <<< "$temp")"
    fi
  fi
}

bindkey -s '^f' '^uff^m'

# bindkey -s '^n' "^utmux popup -d '#{pane_current_path}' -xC -yC -w80% -h80% -E zsh -c 'source "$ZDOTDIR/configs/fzt.zsh" && fzt'^m"
