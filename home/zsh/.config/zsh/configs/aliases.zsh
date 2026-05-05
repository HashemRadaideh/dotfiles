alias please='sudo $(fc -ln -1)'
alias doas='sudo'

alias ls="lsd -F --color=always --group-directories-first"
alias la="lsd -AF --color=always --group-directories-first"
alias l="lsd -lAhF --color=always --group-directories-first"
alias ll="lsd -lAhF --color=always --group-directories-first | bat"
alias lt="lsd -a --tree --color=always --group-directories-first"

alias bat="bat --decorations=always --color=always"
alias cat="bat --decorations=never --color=always --paging=never"

alias rm="trash-put -i"

alias feh='feh --no-fehbg'

alias grep="grep --color=auto"

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

alias mysql-workbench='mysql-workbench --configdir="$XDG_DATA_HOME/mysql/workbench"'
alias yarn='yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config'
alias svn='svn --config-dir $XDG_CONFIG_HOME/subversion'

alias adb='HOME="$XDG_DATA_HOME/android" adb'
alias wine="WINARCH=win64 wine"
alias setupwine="WINARCH=win64 winetricks"
