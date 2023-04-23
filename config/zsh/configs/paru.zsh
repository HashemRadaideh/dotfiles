
# Paru shortcut
alias install="paru -S"
alias uninstall="paru -R"
alias autoremove='paru -Rcns $(pacman -Qdtq)'
alias autoclean='paru -Scc'

update() {
  paru -Syu
  paru -Sua
  reposync  ~/.files/ ~/
  # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 
  nvim --headless "+Lazy! sync" +qa
  doom sync
  ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh
  rustup self upgrade-data
  autoremove
  autoclean
}

