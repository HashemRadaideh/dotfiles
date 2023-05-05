if [ ! -x "$(command -v fzf)"  ]; then
  return
fi

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export FZF_DEFAULT_OPTS='--height=~50% --layout=reverse --border --cycle --preview="bat --decorations=always --color=always {} 2>/dev/null" --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down --exit-0'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude .cache'

fzdm() {
  if [[ -z "$TMUX" ]]; then
    local list=("$(\ls "$XDG_DATA_HOME/sessions" | sort)" "tmux" "$(tty)" "power off" "reboot" "sleep" "logout")
    local file=`printf "%s\n" "${list[@]}" | fzf --border-label=" Fuzzy Display Manager (fzdm) "`

    starter() {
      local extension="${$(grep -P 'export XDG_SESSION_TYPE=*' "$XDG_DATA_HOME/sessions/$1" | awk '{print $2}')//\)}"

      if [[ "$extension" == "XDG_SESSION_TYPE=x11" ]]; then
        startx "$XDG_DATA_HOME/sessions/$1"
      else
        eval "$(\cat $XDG_DATA_HOME/sessions/$1)"
      fi
    }

    if [ -n "$file" ]; then
      case "$file" in
        "logout") exit ;;
        "sleep") systemctl suspend ;;
        "reboot") systemctl reboot ;;
        "power off") systemctl poweroff ;;
        "$(tty)") clear ;;
        "tmux") exec fzt ;;
        *) exec starter "$file" ;;
      esac
    fi
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
