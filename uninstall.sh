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

rollback() {
  local filePath=`dirname "$1"`
  local fileName=`basename "$1"`

  local backups=(`\ls "$filePath" | grep "$fileName"`)

  local sorted=($(sort <<< "${backups[*]}"))

  local newest="${sorted[@]: -1:1}"

  if ! [ "${#sorted[@]}" -eq 1 ]; then
    echo "deleting"
    \rm -rf "$1"
    mv "$filePath/$newest" "$1"
  fi
}

deconfs() {
  rollback /etc/modprobe.d/nobeep.conf

  rollback /etc/X11/xorg.conf.d/30-touchpad.conf

  rollback /etc/pacman.conf
}

switch_shell() {
  if [ -x "$(command -v fzf)"  ]; then
    if grep -Fxq 'export ZDOTDIR="$XDG_CONFIG_HOME/zsh"' /etc/zsh/zshenv; then
      sudo sed -i 's/export ZDOTDIR=.*//' /etc/zsh/zshenv
    fi

    if grep -Fxq 'zsh' "$SHELL"; then
      local choice=`cat /etc/shells | grep "/.*" | fzf`
      chsh -s $choice
    fi

    rm -rf "$XDG_CACHE_HOME/zsh"
  fi
}

rm_symln() {
  sudo rm /usr/share/applications/chrome-*
  sudo rm /usr/share/applications/calculator.desktop

  rollback "$XDG_CONFIG_HOME/alacritty"

  rollback "$XDG_CONFIG_HOME/awesome"

  rollback "$XDG_CONFIG_HOME/fish"

  rollback "$XDG_CONFIG_HOME/kitty"

  rollback "$XDG_CONFIG_HOME/lf"

  rollback "$XDG_CONFIG_HOME/nvim"

  rollback "$XDG_CONFIG_HOME/picom"

  rollback "$XDG_CONFIG_HOME/qtile"

  rollback "$XDG_CONFIG_HOME/qutebrowser"

  rollback "$XDG_CONFIG_HOME/rofi"

  rollback "$XDG_CONFIG_HOME/starship"

  rollback "$XDG_CONFIG_HOME/tmux"

  rollback "$XDG_CONFIG_HOME/zsh"

  rollback "$XDG_CONFIG_HOME/neofetch"

  rollback "$XDG_DATA_HOME/scripts"

  rollback "$XDG_DATA_HOME/misc"

  rollback "$XDG_DATA_HOME/sessions"

  rollback "$XDG_PICTURES_DIR/wallpapers"
}

uninstall_pkgs() {
  cargo uninstall gfold tock zellij

  local packages=( $(cat "$DOTFILES/packages.txt" |tr "\n" " ") )
  # paru -Qq OR paru -Qe | awk '{print $1}'
  paru -Rns $packages
}

emacs_unsetup() {
  if [ -n "$(which emacs)" ]; then
    rollback "$XDG_CONFIG_HOME/emacs"
    rollback "$XDG_CONFIG_HOME/doom"
  fi
}

sudo pacman -R git zsh

git submodule init
git submodule update

switch_shell

deconfs

rm_symln

uninstall_pkgs

emacs_unsetup
