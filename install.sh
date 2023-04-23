#!/bin/sh

sudo pacman -S git zsh

echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a /etc/zsh/zshenv
chsh -s /bin/zsh
mkdir -p ~/.cache/zsh
touch ~/.cache/zsh/history

git clone https://aur.archlinux.org/paru.git ~/paru
makepkg -si ~/paru/PKGBUILD
rm -rf ~/paru

mv ~/.config/alacritty ~/.config/alacritty.bak
ln -s ~/.files/config/alacritty ~/.config/alacritty

mv ~/.config/awesome ~/.config/awesome.bak
ln -s ~/.files/config/awesome ~/.config/awesome

mv ~/.config/fish ~/.config/fish.bak
ln -s ~/.files/config/fish ~/.config/fish

mv ~/.config/kitty ~/.config/kitty.bak
ln -s ~/.files/config/kitty ~/.config/kitty

mv ~/.config/lf ~/.config/lf.bak
ln -s ~/.files/config/lf ~/.config/lf

mv ~/.config/nvim ~/.config/nvim.bak
ln -s ~/.files/config/nvim ~/.config/nvim

mv ~/.config/picom ~/.config/picom.bak
ln -s ~/.files/config/picom ~/.config/picom

mv ~/.config/qtile ~/.config/qtile.bak
ln -s ~/.files/config/qtile ~/.config/qtile

mv ~/.config/qutebrowser ~/.config/qutebrowser.bak
ln -s ~/.files/config/qutebrowser ~/.config/qutebrowser

mv ~/.config/rofi ~/.config/rofi.bak
ln -s ~/.files/config/rofi ~/.config/rofi

mv ~/.config/starship ~/.config/starship.bak
ln -s ~/.files/config/starship ~/.config/starship

mv ~/.config/tmux ~/.config/tmux.bak
ln -s ~/.files/config/tmux ~/.config/tmux

mv ~/.config/zsh ~/.config/zsh.bak
ln -s ~/.files/config/zsh ~/.config/zsh

mv ~/.config/neofetch ~/.config/neofetch.bak
ln -s ~/.files/config/neofetch ~/.config/neofetch

mv ~/.bin ~/bin.bak
ln -s ~/.files/bin ~/.bin

mv ~/Pictures/Wallpapers ~/Pictures/Wallpapers.bak
ln -s ~/.files/wallpapers ~/Pictures/Wallpapers

git clone https://github.com/tmux-plugins/tpm ~/.files/config/tmux/plugins/tpm

make -C ~/.files/config/lf/lfimg install

git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/arc
cd ~/arc && ~/arc/autogen.sh --prefix=/usr
sudo make -C ~/arc install
cd && rm -rf ~/arc

mv ~/.config/emacs ~/.config/emacs.bak
mv ~/.config/doom ~/.config/doom.bak
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
rm -rf ~/.config/doom/
ln -s ~/.files/config/doom ~/.config/doom
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync

# paru -Qq OR paru -Qe | awk '{print $1}'
paru -Syu \
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
