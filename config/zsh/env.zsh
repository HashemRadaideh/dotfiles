# Zsh environment variables

# ADDING TO THE PATH
export PATH="$PATH:$HOME/.bin/scripts:$HOME/.local/bin:$XDG_DATA_HOME/cargo/bin:$HOME/.config/doom/bin:$HOME/.config/emacs/bin:/usr/lib/jvm/java-19-openjdk/bin"

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# $EDITOR use nvim
export EDITOR="nvim"

# $FILEMANAGER
export FILEMANAGER="lf"

# git editor
export GIT_EDITOR="$EDITOR"

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# $OPENER use xdg-open
export OPENER="xdg-open"

# $PAGER uses bat with colors enabled
export PAGER="bat --decorations=always --color=always --paging=always"

# $TERM Sets the terminal
export TERM="alacritty"
# export TERM="kitty"

# $VISUAL uses Emacs in GUI mode
export VISUAL="emacsclient --alternate-editor='emacs' --create-frame"
