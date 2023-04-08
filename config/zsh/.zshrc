source "$ZDOTDIR/zshrc" 2>/dev/null
source "$ZDOTDIR/zshenv" 2>/dev/null
source "$ZDOTDIR/zprofile" 2>/dev/null

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
  add-zsh-hook precmd set-prompt

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
  # Use the starship prompt.
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"

  # Fetch machine's specs.
  neofetch
fi
