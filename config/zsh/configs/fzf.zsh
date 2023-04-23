
alias fzf="fzf --height=~50% --layout=reverse --cycle --border --exit-0"
alias fzp="fzf --preview='bat --decorations=always --color=always {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"

fzdm() {
  if [[ -z "$TMUX" ]]; then
    local list=("$(ls "$HOME/.bin/xinits" | sort)" "tmux" "$(tty)" "power off" "reboot" "sleep" "logout")
    local file=`printf "%s\n" "${list[@]}" | fzf --border-label=" Fuzzy Display Manager (fzdm) " --color=label:italic:white --ansi`

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
    fzf --prompt="Session: " --height=~50% --layout=reverse --cycle --exit-0 <<< "${list[@]}" | awk '{print $1}' | read -t 5 session
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

# bindkey -s '^n' "^utmux popup -d '#{pane_current_path}' -xC -yC -w80% -h80% -E zsh -c 'source "$ZDOTDIR/configs/fzt.zsh" && fzt'^m"
