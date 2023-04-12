# Zsh environment variables

# Home directory clean up

export ANDROID_HOME="$XDG_DATA_HOME/android"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

# export GNUPGHOME="$XDG_DATA_HOME"/gnupg

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# export _JAVA_OPTIONS=-Djava.io.tmpdir="$XDG_CONFIG_HOME"/java
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_RUNTIME_DIR/java"

export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"

export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

export prefix=${XDG_DATA_HOME}/npm
export cache=${XDG_CACHE_HOME}/npm
export tmp=${XDG_RUNTIME_DIR}/npm

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# export WINEPREFIX="$HOME/wine"

# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# export CC=/usr/bin/clang
# export CXX=/usr/bin/clang++

# export SSH_AUTH_SOCK

# $FILEMANAGER 
export FILEMANAGER="lf"

# $EDITOR use nvim
export EDITOR="nvim"

# $OPENER use xdg-open
export OPENER="xdg-open"

# $TERM Sets the terminal
# export TERM="alacritty"
export TERM="kitty"

# $VISUAL uses Emacs in GUI mode
export VISUAL="/usr/bin/emacsclient --alternate-editor='/usr/bin/emacs' --create-frame"

# $PAGER uses bat with colors enabled
export PAGER="bat --decorations=always --color=always --paging=always"

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# $HOSTNAME current machine hostname
export HOSTNAME="$(/bin/hostnamectl | grep 'Static hostname: ' | awk '{print $3}')"

# $DISTRO current linux distribution
export DISTRO="$(hostnamectl | grep 'Operating System' | awk '{ print substr($0, index($0,$3)) }')"

# IPv4 address.
export IPv4="${$(ip a | grep -P '^.*(?=.*inet )(?=.*dynamic).*$' | awk '{print $2}')//\/*}"

alias lsxkbmodels="sed '/^! model$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
alias lsxkblayouts="sed '/^! layout$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
alias lsxkbvariants="sed '/^! variant$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
alias lsxkboptions="sed '/^! option$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"

alias viewxkb="less -M '+/^\s*\!\s\w+$' /usr/share/X11/xkb/rules/base.lst"
alias viewxkbmodels="lsxkbmodels | less -M"
alias viewxkblayouts="lsxkblayouts | less -M"
alias viewxkbvariants="lsxkbvariants | less -M"
alias viewxkboptions="lsxkboptions | less -M"

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

alias ...='../..'

alias feh='feh --no-fehbg'

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

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
