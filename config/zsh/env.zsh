configs=(
  aliases
  cmake
  docker
  fzf
  lf
  nvim
  pacman
  utils
  wine
)

export TERMINAL="alacritty"

# History in cache directory:
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export HISTSIZE=10000000
export SAVEHIST=10000000

# export CC=`which clang`
# alias cc=`which clang`

# export CXX=`which clang++`
# alias cpp=`which clang++`

# $EDITOR use nvim
export EDITOR="nvim"

# $FILEMANAGER
export FILEMANAGER="lf"

# git editor
export GIT_EDITOR="$EDITOR"

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# $OPENER use xdg-open
export OPENER="xdg-open"

# $PAGER uses bat with colors enabled
export PAGER="bat --decorations=always --color=always --paging=always"

# $VISUAL uses Emacs in GUI mode
export VISUAL="emacsclient --alternate-editor='emacs' --create-frame"

zenv() { }
