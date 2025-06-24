# $HOSTNAME current machine hostname
export HOSTNAME="$(hostnamectl | grep 'Static hostname: ' | awk '{print $3}')"

# $DISTRO current linux distribution
export DISTRO="$(hostnamectl | grep 'Operating System' | awk '{ print substr($0, index($0,$3)) }')"

# IPv4 address.
export IPv4="${$(ip a | grep -P '^.*(?=.*inet )(?=.*dynamic).*$' | awk '{print $2}')//\/*}"
export IPv6="${$(ip a | grep -P '^.*(?=.*inet6 )(?=.*dynamic).*$' | awk '{print $2}')//\/*}"

# xkb
# alias lsxkbmodels="sed '/^! model$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
# alias lsxkblayouts="sed '/^! layout$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
# alias lsxkbvariants="sed '/^! variant$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"
# alias lsxkboptions="sed '/^! option$/,/^ *$/!d;//d' /usr/share/X11/xkb/rules/base.lst"

# alias viewxkb="less -M '+/^\s*\!\s\w+$' /usr/share/X11/xkb/rules/base.lst"
# alias viewxkbmodels="lsxkbmodels | less -M"
# alias viewxkblayouts="lsxkblayouts | less -M"
# alias viewxkbvariants="lsxkbvariants | less -M"
# alias viewxkboptions="lsxkboptions | less -M"

export alacritty="WINIT_X11_SCALE_FACTOR=1.66 alacritty"

alias e="$EDITOR"
bindkey -s '^e' "^u$EDITOR^m"
alias v="$VISUAL"

# Changing "ls" to "exa"
# alias ls="exa -F --icons --color=always --group-directories-first"    # my preferred listing
# alias la="exa -aF --icons --color=always --group-directories-first"   # all files and dirs
# alias l="exa -lahF --icons --color=always --group-directories-first"  # long format
# alias ll="exa -lahF --icons --color=always --group-directories-first | bat"  # paged long format
alias lt="eza -aT --icons --color=always --group-directories-first"   # tree listing

# Changing "ls" to "lsd"
alias ls="lsd -F --color=always --group-directories-first"    # my preferred listing
alias la="lsd -AF --color=always --group-directories-first"   # all files and dirs
alias l="lsd -lAhF --color=always --group-directories-first"  # long format
alias ll="lsd -lAhF --color=always --group-directories-first | bat"  # paged long format
# alias lt="lsd -aT --color=always --group-directories-first"   # tree listing

# emacs shortcuts
alias emacs="/usr/bin/emacsclient -c -a '/usr/bin/emacs'" # client emacs gui
alias em="/usr/bin/emacs -nw" # terminal emacs editor

# tmux with unicode shortcut
alias tmux="tmux -u"

# colored bat with paging
alias bat="bat --decorations=always --color=always"

alias paru="paru --bottomup"

# Clear
# alias clear="clear && pfetch" # | lolcat"

# Start / Open (Windows and Mac)
# alias start="xdg-open"
# alias open="xdg-open"

# Lazy shortcuts
alias lg="lazygit"
alias lc="lazydocker"

# Glow shortcut
# alias gl="glow"

alias cmatrix='cmatrix -b -u 3 -C cyan'

# tock centered with cyan coloring shortcut
alias tock='tock -c -C 6'

# please is a "sudo !!" alias
# alias please='sudo $(!!)'
alias please='sudo $(fc -ln -1)'
# alias doas='sudo'

# replace "rm" with "trash-put -i"
alias rm="trash-put -i"

# alias ...='cd ../..'

alias feh='feh --no-fehbg'

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

alias gpg='gpg --homedir="$HOME"'

alias mysql-workbench=mysql-workbench --configdir="$XDG_DATA_HOME/mysql/workbench"
alias yarn='yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config'
alias svn='svn --config-dir $XDG_CONFIG_HOME/subversion'

alias ruby='PAGER=cat ruby'

conda-open() {
    eval "$($XDG_DATA_HOME/miniforge3/bin/conda shell.zsh hook)"
}

visudo() {
    sudo EDITOR=$EDITOR visudo
}
