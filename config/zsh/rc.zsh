export DOTFILES="$HOME/.files"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/bin"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

export PATH="$PATH:$XDG_DATA_HOME:$XDG_DATA_HOME/scripts:$XDG_DATA_HOME/sessions:$XDG_DATA_HOME/cargo/bin:$XDG_CONFIG_HOME/doom/bin:$XDG_CONFIG_HOME/emacs/bin:/usr/lib/jvm/java-19-openjdk/bin"

export CC=`which clang`
alias cc=`which clang`

export CXX=`which clang++`
alias cpp=`which clang++`

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

# $TERM Sets the terminal
export TERM="alacritty"
# export TERM="kitty"

# $VISUAL uses Emacs in GUI mode
export VISUAL="emacsclient --alternate-editor='emacs' --create-frame"

# home directory clean up
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupm"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GTK_2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# History in cache directory:
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export HISTSIZE=10000000
export SAVEHIST=10000000

configs=(
  aliases
  cmake
  docker
  lf
  nvim
  paru
  utils
  wine
)

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  # zsh-history-substring-search
  # zsh-auto-notify
  # zsh-you-should-use
)

zrc() {
  require "configs/fzf"

  if [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]] ; then
    [ -x "$(command -v fzf)"  ] && fzdm
  fi

  # Auto start tmux in ssh.
  [ -x "$(command -v fzf)"  ] && [[ -n "$SSH_CONNECTION" ]] && exec fzt

  [ -x "$(command -v gh)"  ] && eval "$(gh completion -s zsh)"

  [ -x "$(command -v zoxide)"  ] && eval "$(zoxide init zsh)"

  if [[ -z "$DISPLAY" ]] ; then
    # Use the custom zsh prompt.
    require "configs/prompt" && hash-prompt

    # Fetch machine's specs.
    [ -x "$(command -v pfetch)"  ] && pfetch
  else
    require "configs/starship" && starship-prompt

    # Fetch machine's specs.
    [ -x "$(command -v neofetch)"  ] && neofetch
  fi

  if [[ -z "$TMUX" ]]; then
    TMOUT=120
    TRAPALRM() { asciiquarium }
    # pipes.sh | tock | cmatrix -s | asciiquarium
  fi
}
