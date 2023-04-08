# Zsh environment variables

alias lsxkbmodels="sed '/^! model$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
alias lsxkblayouts="sed '/^! layout$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
alias lsxkbvariants="sed '/^! variant$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
alias lsxkboptions="sed '/^! option$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"

alias viewxkb="less -M '+/^\s*\!\s\w+$' /usr/share/X11/xkb/rules/base.lst"
alias viewxkbmodels="lsxkbmodels | less -M"
alias viewxkblayouts="lsxkblayouts | less -M"
alias viewxkbvariants="lsxkbvariants | less -M"
alias viewxkboptions="lsxkboptions | less -M"

# lf configurations
source "$HOME/.config/zsh/lf.sh"

# Git configurations 
source "$HOME/.config/zsh/git.sh"

# startx alias
alias x="startx"

alias e="$EDITOR"
bindkey -s '^e' "^u$EDITOR^m"
alias v="$VISUAL"

# nvim shortcut
alias nv="nvim"
alias vi="nvim"
alias vim="nvim"

# client emacs gui
alias emacs="emacsclient -c -a 'emacs'"

# terminal emacs editor
alias em="/usr/bin/emacs -nw"

# tmux with unicode shortcut
alias tmux="tmux -u"

# colored bat with paging
alias bat="bat --decorations=always --color=always --paging=always"

# colored less
alias less="less -R"

# Changing "ls" to "exa"
alias ls="exa -F --icons --color=always --group-directories-first"    # my preferred listing
alias la="exa -aF --icons --color=always --group-directories-first"   # all files and dirs
alias l="exa -lahF --icons --color=always --group-directories-first"  # long format
alias ll="exa -lahF --icons --color=always --group-directories-first | bat"  # long format
alias lt="exa -aT --icons --color=always --group-directories-first"   # tree listing

# Clear
alias clear="clear && pfetch" # | lolcat"

# Start / Open (Windows and Mac)
alias start="xdg-open"
alias open="xdg-open"

# Lazygit shortcut
alias lg="lazygit"

# Glow shortcut
alias gl="glow"

# Git shortcut
alias g="git"

alias cmatrix='cmatrix -b -u 3 -C cyan'

# tock centered with cyan coloring shortcut
alias tock='tock -c -C 6'

alias fm="exec fuzmux"

# please is a "sudo !!" alias
# alias please='sudo $(!!)'
alias please='sudo $(fc -ln -1)'
alias doas='sudo'

# replace "rm" with "trash-put -i"
alias rm="trash-put -i"

# Paru shortcut
alias install="paru -S"
alias uninstall="paru -R"
alias autoremove='paru -Rcns $(pacman -Qdtq)'
alias autoclean='paru -Scc'

alias ...='../..'

runwin() {
  WINARCH=win64
  wine "$2"
}

setupwin() {
  WINARCH=win64
  winetricks
}

update() {
  paru -Syyuu 
  reposync ~/.config/ ~/.bin/ ~/
  nvim --headless -n -u ~/.config/nvim/init.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 
  doom sync
  ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh
  rustup self upgrade-data
  autoremove
  autoclean
}

# Key testing
testkey() {
  xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
}

# Window managers testing utility
testwm() {
  Xephyr :5 -resizeable  & sleep 1 ; DISPLAY=:5 "$1" # wmctrl -r :5 -e 0,0,0,100,100
}

testcolors() {
  for x in {0..8}; do 
    for i in {30..37}; do 
      for a in {40..47}; do 
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
      done

      echo
    done
  done
}

lookfor() {
  sudo find / -iname "$1"
}

mk() {
  if [[ "$(echo "${1:${#1}-1:1}")" == "/" ]]; then
    mkdir -p $1
    return;
  fi

  if echo "$1" | grep -q "/"; then
    mkdir -p "$(sed 's/\(.*\)\/.*/\1/' <<< "$1")" && touch "$1"
    return;
  fi

  touch "$1"
}

ff() {
	dirs="$(find . | fzf --header='Jump to:')"
  if [[ "$dirs" == "." ]]; then
    cd
  fi

  if [ -d "$dirs" ]; then
    cd "$dirs"
  else
    cd "$(sed 's/\(.*\)\/.*/\1/' <<< "$dirs") && $EDITOR $(sed 's/.*\/\(.*\)/\1/' <<< "$dirs")"
  fi
}

# bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
bindkey -s '^f' '^uff^m'

flash() {
  notify-send "$1"
  notify-send "$1" -t 5000
  sudo dd bs=4M if="$1" of="$2" conv=fdatasync  status=progress
  notify-send "$2 created successfully"
}

codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# the following 6 functions are unnecessary
:q() {
  exit
}

:wq() {
  exit
}

:wqa() {
  exit
}

:qa() {
  exit
}

:x() {
  exit
}

:xa() {
  exit
}

q() {
  exit
}
