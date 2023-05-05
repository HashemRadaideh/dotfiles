#!/bin/sh

DOTFILES="${DOTFILES:-$HOME/.files}"

XDG_CACHE_HOME="${DOTFILES:-$HOME/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/bin}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-$HOME/Public}"
XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-$HOME/Templates}"
XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"

mkbackup() {
  if [ -f "$1" ] || [ -d "$1" ]; then
    mv "$1" "$1.$(date +%Y-%m-%d_%H-%M-%S).bak"
  fi
}

confs() {
  sudo rmmod pcspkr
  sudo rmmod snd_pcsp

  sudo mkbackup /etc/modprobe.d/nobeep.conf
  sudo ln -s "$DOTFILES/bin/confs/nobeep.conf" /etc/modprobe.d/nobeep.conf

  sudo mkbackup /etc/X11/xorg.conf.d/30-touchpad.conf
  sudo ln -s "$DOTFILES/bin/confs/30-touchpad.conf" /etc/X11/xorg.conf.d

  sudo mkbackup /etc/pacman.conf
  sudo ln -s "$DOTFILES/bin/confs/pacman.conf" /etc
}

default_shell() {
  if [ -x "$(command -v zsh)"  ]; then
    if ! grep -Fxq 'export ZDOTDIR="$XDG_CONFIG_HOME/zsh"' /etc/zsh/zshenv; then
      echo "export ZDOTDIR=\"$XDG_CONFIG_HOME/zsh\"" | sudo tee -a /etc/zsh/zshenv
    fi

    if ! grep -Fxq 'zsh' "$SHELL"; then
      chsh -s `which zsh`
    fi

    if [ -f "$XDG_CACHE_HOME/zsh/history" ]; then
      mkdir -p "$XDG_CACHE_HOME/zsh"
      touch "$XDG_CACHE_HOME/zsh/history"
    fi
  fi
}

mk_symln() {
  mkdir -p "$XDG_DESKTOP_DIR" "$XDG_DOCUMENTS_DIR" "$XDG_DOWNLOAD_DIR" "$XDG_MUSIC_DIR" "$XDG_PICTURES_DIR" "$XDG_PUBLICSHARE_DIR" "$XDG_TEMPLATES_DIR" "$XDG_VIDEOS_DIR""$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

  sudo ln -s "$DOTFILES/bin/desktop/*" /usr/share/applications

  mkbackup "$XDG_CONFIG_HOME/alacritty"
  ln -s "$DOTFILES/config/alacritty" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/awesome"
  ln -s "$DOTFILES/config/awesome" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/fish"
  ln -s "$DOTFILES/config/fish" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/hypr"
  ln -s "$DOTFILES/config/hypr" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/kitty"
  ln -s "$DOTFILES/config/kitty" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/lf"
  ln -s "$DOTFILES/config/lf" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/nvim"
  ln -s "$DOTFILES/config/nvim" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/picom"
  ln -s "$DOTFILES/config/picom" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/qtile"
  ln -s "$DOTFILES/config/qtile" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/qutebrowser"
  ln -s "$DOTFILES/config/qutebrowser" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/rofi"
  ln -s "$DOTFILES/config/rofi" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/starship"
  ln -s "$DOTFILES/config/starship" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/tmux"
  ln -s "$DOTFILES/config/tmux" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/zsh"
  ln -s "$DOTFILES/config/zsh" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/neofetch"
  ln -s "$DOTFILES/config/neofetch" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_DATA_HOME/scripts"
  ln -s "$DOTFILES/bin/scripts" "$XDG_DATA_HOME"

  mkbackup "$XDG_DATA_HOME/misc"
  ln -s "$DOTFILES/bin/misc" "$XDG_DATA_HOME"

  mkbackup "$XDG_DATA_HOME/sessions"
  ln -s "$DOTFILES/bin/sessions" "$XDG_DATA_HOME"

  mkbackup "$XDG_PICTURES_DIR/wallpapers"
  ln -s "$DOTFILES/wallpapers" "$XDG_PICTURES_DIR"

  mkbackup "$XDG_CONFIG_HOME/hypr"
  ln -s "$DOTFILES/config/hypr" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/swaylock"
  ln -s "$DOTFILES/config/swaylock" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/waybar"
  ln -s "$DOTFILES/config/waybar" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/wlogout"
  ln -s "$DOTFILES/config/wlogout" "$XDG_CONFIG_HOME"

  mkbackup "$XDG_CONFIG_HOME/mako"
  ln -s "$DOTFILES/config/mako" "$XDG_CONFIG_HOME"
}

install_pkgs() {
  RUSTUP_HOME="$XDG_DATA_HOME/rustup"
  CARGO_HOME="$XDG_DATA_HOME/cargo"
  GOPATH="$XDG_DATA_HOME/go"

  git clone https://aur.archlinux.org/paru.git /tmp/paru
  makepkg -si /tmp/paru/PKGBUILD

  rustup default stable

  local packages=( $(\cat "$DOTFILES/packages.txt" | tr "\n" " ") )
  paru -Syu $packages

  cargo install gfold tock zellij
}

emacs_setup() {
  if [ -n "$(which emacs)" ]; then
    mkbackup "$XDG_CONFIG_HOME/emacs"
    mkbackup "$XDG_CONFIG_HOME/doom"
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$XDG_CONFIG_HOME/emacs"
    "$XDG_CONFIG_HOME/emacs/bin/doom" install
    rm -rf "$XDG_CONFIG_HOME/doom/"
    ln -s "$DOTFILES/config/doom" "$XDG_CONFIG_HOME/doom"
    "$XDG_CONFIG_HOME/emacs/bin/doom" install
    "$XDG_CONFIG_HOME/emacs/bin/doom" sync
  fi
}

arc_icons() {
  if [ -n "$(which awesome)" ]; then
    local current_dir=`pwd`
    git clone https://github.com/horst3180/arc-icon-theme --depth 1 /tmp/arc
    cd /tmp/arc && arc/autogen.sh --prefix=/usr
    sudo make -C /tmp/arc install
    cd "$current_dir"
  fi
}

sudo pacman -S git zsh

git submodule init
git submodule update

default_shell

confs

mk_symln

install_pkgs

sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service

emacs_setup

arc_icons
