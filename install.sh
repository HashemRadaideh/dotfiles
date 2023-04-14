#!/bin/sh

sudo pacman -S git zsh

git clone https://aur.archlinux.org/paru.git ~/paru
makepkg -si ~/paru/PKGBUILD
rm -rf ~/paru

echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a /etc/zsh/zshenv
chsh -s /bin/zsh
mkdir -p ~/.cache/zsh
touch ~/.cache/zsh/history

ln -s ~/dotfiles/config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/config/awesome ~/.config/awesome
ln -s ~/dotfiles/config/fish ~/.config/fish
ln -s ~/dotfiles/config/kitty ~/.config/kitty
ln -s ~/dotfiles/config/lf ~/.config/lf
ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/config/picom ~/.config/picom
ln -s ~/dotfiles/config/qtile ~/.config/qtile
ln -s ~/dotfiles/config/qutebrowser ~/.config/qutebrowser
ln -s ~/dotfiles/config/rofi ~/.config/rofi
ln -s ~/dotfiles/config/starship ~/.config/starship
ln -s ~/dotfiles/config/tmux ~/.config/tmux
ln -s ~/dotfiles/config/zsh ~/.config/zsh
ln -s ~/dotfiles/config/neofetch ~/.config/neofetch

ln -s ~/dotfiles/bin ~/.bin
ln -s ~/dotfiles/wallpapers ~/Pictures/Wallpapers

git clone https://github.com/tmux-plugins/tpm ~/dotfiles/config/tmux/plugins/tpm

make -C ~/dotfiles/config/lf/lfimg install

git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/arc
cd ~/arc && ~/arc/autogen.sh --prefix=/usr
sudo make -C ~/arc install
cd && rm -rf ~/arc

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
rm -rf ~/.config/doom/
ln -s ~/dotfiles/config/doom ~/.config/doom
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync

# paru -Qq OR paru -Qe | awk '{print $1}'
paru -Syyuu \
  otf-cascadia-code-nerd \
  ttf-firacode-nerd \
  ttf-sourcecodepro-nerd \
  ttf-jetbrains-mono-nerd \
  ttf-hack-nerd \
  ttf-dejavu-nerd \
  github-cli \
  rustup \
  zig \
  cmake \
  clang \
  lua \
  luarocks \
  ruby \
  clojure \
  ghc \
  octave \
  go \
  pypy \
  python \
  bun-bin \
  nodejs \
  npm \
  yarn \
  gradle \
  maven \
  jdk-openjdk \
  jre-openjdk \
  dotnet-sdk \
  dotnet-runtime \
  lsd \
  exa \
  bat \
  ripgrep \
  fd \
  zoxide \
  starship \
  tmux \
  byobu \
  fzf \
  kitty \
  picom \
  nitrogen \
  alsa-utils \
  rofi \
  lf \
  ueberzug \
  graphicsmagick \
  ghostscript \
  thunar \
  screenkey \
  scrot \
  lazygit \
  glow \
  neovide \
  emacs \
  umbrello \
  pycharm-community-edition \
  intellij-idea-community-edition \
  qtcreator \
  obsidian \
  libreoffice \
  discord \
  steam \
  wine \
  winetricks \
  lutris \
  blender \
  virt-manager \
  virtualbox \
  sl \
  cmatrix \
  gpick \
  conky \
  dmenu \
  feh \
  kdenlive \
  gimp \
  lolcat \
  lxappearance \
  qt5ct \
  mdcat \
  mpv \
  ncmpcpp \
  neofetch \
  network-manager-applet \
  networkmanager \
  obs-studio \
  pavucontrol \
  tldr \
  trash-cli \
  zathura \
  zathura-pdf-poppler \
  xautolock \
  xclip \
  xdelta3 \
  xf86-video-amdgpu \
  xf86-video-ati \
  xf86-video-nouveau \
  xf86-video-vmware \
  xf86-input-libinput \
  xorg-server \
  xorg-server-xephyr \
  xorg-xev \
  xorg-xinit \
  xterm \
  zram-generator \
  i3lock-color-git \
  awesome-git \
  acpi \
  nomacs-git \
  openboard-git \
  cava-git \
  krita-git \
  nordic-theme-git \
  xdg-ninja-git \
  neovim-nightly \
  drawio \
  staruml \
  code-git \
  android-studio \
  unityhub \
  google-chrome-dev \
  brave-bin \
  onlyoffice-bin \
  notion-app \
  trello \
  evernote-beta-bin \
  tradingview \
  zoom \
  teams \
  spotify-dev \
  pipes.sh \
  pfetch \
  typora \
  xdiskusage \
  xidlehook \
  xss-lock

rustup default stable

cargo install tock gfold zellij
