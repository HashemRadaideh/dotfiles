# Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" 2>/dev/null
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" 2>/dev/null

# cmake shortcuts
source "$ZDOTDIR/configs/cmake.zsh" 2>/dev/null

# codi shortcuts
source "$ZDOTDIR/configs/codi.zsh" 2>/dev/null

# Git configurations
source "$ZDOTDIR/configs/git.zsh" 2>/dev/null

# lf configurations
source "$ZDOTDIR/configs/lf.zsh" 2>/dev/null

# nvim configurations
source "$ZDOTDIR/configs/nvim.zsh" 2>/dev/null

# paru configurations
source "$ZDOTDIR/configs/paru.zsh" 2>/dev/null

# Hash prompt
source "$ZDOTDIR/configs/prompt.zsh" 2>/dev/null

# Starship prompt
source "$ZDOTDIR/configs/starship.zsh" 2>/dev/null

# utilities
source "$ZDOTDIR/configs/utils.zsh" 2>/dev/null

# wine configurations
source "$ZDOTDIR/configs/wine.zsh" 2>/dev/null

main() {
  TMOUT=120
  TRAPALRM() { tock } # { pipes.sh } # { cmatrix -s }

  # Auto start tmux in ssh.
  if [[ -n "$SSH_CONNECTION" ]] ; then
    exec fuzmux
  fi

  if [[ -z "$DISPLAY" ]] ; then
    # Use the custom zsh prompt.
    autoload -Uz add-zsh-hook
    hash-prompt

    if [[ -z "$TMUX" ]]; then
      file="$(fzf --layout=reverse --cycle <<< `echo "$(\ls ~/.bin/xinit | sort)\ntmux\n$(tty)\npower off\nreboot\nsleep\nlogout"`)"

      if [ -n "$file" ]; then
        case "$file" in
          "logout") exit ;;
          "sleep") systemctl suspend ;;
          "reboot") systemctl reboot ;;
          "power off") systemctl poweroff ;;
          "$(tty)") clear setterm -blength 0 && set bell-style none ;;
          "tmux") exec fuzmux ;;
          *) exec startx ~/.bin/xinit/"$file" ;;
        esac
      fi
    fi
  else
    starship-prompt

    # Fetch machine's specs.
    neofetch
  fi
}
