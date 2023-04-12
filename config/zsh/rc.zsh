configs=(
  cmake
  codi
  git
  lf
  nvim
  paru
  prompt
  starship
  utils
  wine
)

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  zsh-auto-notify
  zsh-you-should-use
)

main() {
  TMOUT=120
  TRAPALRM() { tock } # { pipes.sh } # { cmatrix -s }
  eval "$(zoxide init zsh)"

  # Auto start tmux in ssh.
  if [[ -n "$SSH_CONNECTION" ]] ; then
    exec fuzmux
  fi

  if [[ -z "$DISPLAY" ]] ; then
    if [[ -z "$TMUX" ]]; then
      file="$(fzf --layout=reverse --cycle <<< `echo "$(\ls ~/.bin/xinit | sort)\ntmux\n$(tty)\npower off\nreboot\nsleep\nlogout"`)"

      if [ -n "$file" ]; then
        case "$file" in
          "logout") exit ;;
          "sleep") systemctl suspend ;;
          "reboot") systemctl reboot ;;
          "power off") systemctl poweroff ;;
          "$(tty)") clear ;;
          "tmux") exec fuzmux ;;
          *) exec startx ~/.bin/xinit/"$file" ;;
        esac
      fi
    fi

    # Use the custom zsh prompt.
    autoload -Uz add-zsh-hook
    hash-prompt

    # Fetch machine's specs.
    pfetch
  else
    starship-prompt

    # Fetch machine's specs.
    neofetch
  fi
}
