# .zshrc

# ADDING TO THE PATH
export PATH="$PATH:$HOME/.bin/scripts:$HOME/.local/bin:$XDG_DATA_HOME/cargo/bin:$HOME/.config/doom/bin:$HOME/.config/emacs/bin:/usr/lib/jvm/java-19-openjdk/bin"

# XDG Variables
export XDG_DATA_HOME="$HOME/.local/bin"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh configurations
source "$ZDOTDIR/rc.zsh" 2>/dev/null
source "$ZDOTDIR/env.zsh" 2>/dev/null

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

bindkey -s '^n' '^ufuzmux^m'

TMOUT=120
TRAPALRM() { tock } # { pipes.sh } # { cmatrix -s }

# Auto start tmux in ssh.
if [[ -n "$SSH_CONNECTION" ]] ; then
  exec fuzmux
fi

if [[ -z "$DISPLAY" ]] ; then
  # Use the custom zsh prompt.
  setterm -blength 0
  set bell-style none

  autoload -Uz add-zsh-hook
  hash-prompt

  exec shdm
else
  starship-prompt

  # Fetch machine's specs.
  neofetch
fi
