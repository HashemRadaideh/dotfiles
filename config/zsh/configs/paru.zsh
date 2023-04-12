
# Paru shortcut
alias install="paru -S"
alias uninstall="paru -R"
alias autoremove='paru -Rcns $(pacman -Qdtq)'
alias autoclean='paru -Scc'

update() {
  paru -Syyuu 
  reposync  ~/dotfiles/ ~/
  nvim --headless -n -u ~/.config/nvim/init.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 
  doom sync
  ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh
  rustup self upgrade-data
  autoremove
  autoclean
}

