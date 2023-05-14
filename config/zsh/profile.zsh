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

# home directory clean up
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupm"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GTK_2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="kvantum"

export PATH="$PATH:$XDG_DATA_HOME:$XDG_DATA_HOME/scripts:$XDG_DATA_HOME/sessions:$XDG_DATA_HOME/cargo/bin:$GOPATH/bin/:$XDG_CONFIG_HOME/doom/bin:$XDG_CONFIG_HOME/emacs/bin:/usr/lib/jvm/default/bin"

zprofile() {
  # Auto start tmux in ssh.
  [ -x "$(command -v fzf)"  ] && [[ -n "$SSH_CONNECTION" ]] && exec fzt

  if [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]] ; then
    [ -x "$(command -v fzf)"  ] && exec fzdm
  fi
}
