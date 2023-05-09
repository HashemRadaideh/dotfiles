neofetch

set -xU STARSHIP_CONFIG $HOME/.config/starship/starship.toml

starship init fish | source

## ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths $HOME/.cargo/bin

### SET EITHER DEFAULT EMACS MODE OR VI MODE
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

### AUTOCOMPLETE AND HIGHLIGHT COLORS
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

# XDG variables
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=awesome
export XDG_DATA_HOME="$HOME/.local/bin/"
export XDG_CONFIG_HOME="$HOME/.config/"
# export XDG_CONFIG_DIRS="$HOME/"
export XDG_STATE_HOME="$HOME/.local/state/"
export XDG_CACHE_HOME="$HOME/.cache/"

### EXPORT
if not test -n $SSH_CONNECTION
  set -x EDITOR "nvim"  # $EDITOR use nvim in ssh sessions
else
  set -x EDITOR "nvim"  # $EDITOR use nvim in local sessions
end
set -x fish_greeting  # Supresses fish's intro message
set -x TERMINAL "alacritty"  # Sets the terminal type
# set -x OPENER="xdg-open"  # $OPENER use xdg-open in local sessions
set -x VISUAL "emacsclient -c -a 'emacs'"  # $VISUAL use Emacs in GUI mode

alias e="$EDITOR"
alias v="$VISUAL"

# "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# colored less
alias less="less -R"

# colored bat with paging
alias bat="bat --decorations=always --color=always --paging=always"

# nvim shortcut
alias nv="nvim"

# terminal emacs editor
alias em="/usr/bin/emacs -nw"

# client emacs gui
alias emacs="emacsclient -c -a 'emacs'"

# Changing "ls" to "exa"
alias ls="exa -F --icons --color=always --group-directories-first"    # my preferred listing
alias la="exa -aF --icons --color=always --group-directories-first"   # all files and dirs
alias ll="exa -laF --icons --color=always --group-directories-first"  # long format
alias lt="exa -aT --icons --color=always --group-directories-first"   # tree listing

# Clear
alias clear="clear && pfetch | lolcat"

# Start / Open (Windows and Mac)
alias start="xdg-open"
alias open="xdg-open"

# Lazygit shortcut
alias lg="lazygit"

# Glow shortcut
alias gl="glow"

# replace "rm" with "trash-put -i"
alias rm="trash-put -i"

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ]
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# # please is a "sudo !!" alias
function please
  eval command sudo $history[1]
end

# Key testing
function testkey
  xev | grep -A2 --line-buffered '^KeyRelease' | sed \
  -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
end

# Window managers testing utility
function testwm
  Xephyr :5 -resizeable  & sleep 1 ; DISPLAY=:5 $1 # wmctrl -r :5 -e 0,0,0,100,100
end

function mk
  set x (string sub -s -1 "rc.luh")
  if test $x = "/"
    mkdir -p $argv
    return;
  end

  if echo "$argv" | grep -q "/"
    mkdir -p $(echo "$argv" | sed 's/\/.*//') 
    touch $argv
    cd $(echo "$argv" | sed 's/.*\///')
    return;
  end

  touch $argv
end

function ff
	set dirs (find . | fzf --header='Jump to:')
  if test $dirs = "."
    cd
  end

  if [ -d "$dirs" ]
    cd "$dirs"
  else
    cd (echo $dirs | sed 's/\(.*\)\/.*/\1/') && $EDITOR (echo $dirs | sed 's/.*\/\(.*\)/\1/')
  end
end

bind \cf 'ff'

# this is quit unnecessary, but it's a good habit to have :3
function :q
  exit
end

function :wq
  exit
end

function :wqa
  exit
end

function :qa
  exit
end

function :x
  exit
end

function :xa
  exit
end

source ~/.config/fish/lf.fish
