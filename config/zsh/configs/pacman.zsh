if [ ! -x "$(command -v paru)"  ]; then
  return
fi

# Paru shortcut
clean() {
  paru -Rcnsdd $(pacman -Qdtq)
  paru -Scc
}

download() {
  local pkgman='pacman'
  [ -x "$(command -v paru)" ] && pkgman='paru'

  $pkgman -S $@

  touch "$DOTFILES/packages.txt" 2> /dev/null

  if [ $? -eq 0 ]; then
    for item in "$@"; do
      if ! rg -q "^$item$" "$DOTFILES/packages.txt" ; then
        echo "$item" >> "$DOTFILES/packages.txt"
      fi
    done
  fi
}

delete() {
  local pkgman='pacman'
  [ -x "$(command -v paru)" ] && pkgman='paru'

  $pkgman -Rnsdd $@

  if [ $? -eq 0 ] && [ -f "$DOTFILES/packages.txt" ]; then
    for item in "$@"; do
      if rg -q "^$item$" "$DOTFILES/packages.txt"; then
        sed -i "/^$item$/d" "$DOTFILES/packages.txt"
      fi
    done
  fi
}

update() {
  local pkgman='pacman'
  [ -x "$(command -v paru)" ] && pkgman='paru'

  $pkgman -Syu

  [ -x "$(command -v paru)" ] && $pkgman -Sua

  reposync  ~/.files/ ~/

  # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 
  nvim --headless "+Lazy! sync" +qa

  doom sync

  ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh

  rustup self upgrade-data

  clean

  sort "$DOTFILES/packages.txt" | uniq --unique > "$DOTFILES/packages.txt"
}
