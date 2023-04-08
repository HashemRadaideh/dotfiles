# Zsh config file (zshrc without oh-my-zsh)

export SSH_AUTH_SOCK

# ADDING TO THE PATH
export PATH="$PATH:$HOME/.bin/scripts:$HOME/.local/bin:$XDG_DATA_HOME/cargo/bin:$HOME/.config/doom/bin:$HOME/.config/emacs/bin"

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

# History in cache directory:
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export HISTSIZE=10000000
export SAVEHIST=10000000

# Completion engine setup
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' glob 'x == 2'
zstyle ':completion:*' matcher-list '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' max-errors 5 numeric
zstyle :compinstall filename '$HOME/.config/zsh/.zshrc'

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

setopt autocd beep extendedglob nomatch notify

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# vi mode setup
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
  case "$KEYMAP" in
    vicmd) echo -ne '\e[1 q' ;;      # block
    viins|main) echo -ne '\e[5 q' ;; # beam
  esac
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.

preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
eclf() {
  autoload edit-command-line; zle -N edit-command-line
  export VISUAL='nvim'
  edit-command-line
  export VISUAL="emacsclient -c -a 'emacs'"
}

autoload eclf; zle -N eclf

bindkey -M vicmd e eclf
# bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' eclf
# bindkey -M visual '^[[P' vi-delete

# Default key mappings
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# histroy search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey '^K' up-line-or-beginning-search
bindkey '^J' down-line-or-beginning-search

# easy move between words
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Ctrl+Backspace: kill the word backward
bindkey -M emacs '^H' backward-kill-word
bindkey -M viins '^H' backward-kill-word
bindkey -M vicmd '^H' backward-kill-word

# Ctrl+Delete: kill the word forward
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# use showkey -a or Ctrl-v to get key code for binding

# Prompt setup.
autoload -U colors && colors
prompt-length() {
  emulate -L zsh
    local -i x y="${#1}" m
    if (( y )); then
      while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
        x=y
        (( y *= 2 ))
      done
      while (( y > x + 1 )); do
        (( m = x + (y - x) / 2 ))
        (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
      done
    fi
  echo "$x"
}

fill-line() {
  local left_len="$(prompt-length "$1")"
  local right_len="$(prompt-length "$2")"
  local pad_len="$((COLUMNS - left_len - right_len - 1))"
  local pad="${(pl.$pad_len.. .)}"  # pad_len spaces
  echo "${1}${pad}${2}"
}

set-prompt() {
  local ret="$?"
  local top_left="%B%F{yellow}%n\
$(if [[ -n $SSH_CONNECTION ]]; then
  echo "%F{gray}@%F{blue}%M";
fi)\
$(if [[ -z $(git rev-parse --abbrev-ref HEAD 2>/dev/null) ]]; then
  echo '%F{gray} in %F{magenta}%~';
else
  echo "\
%F{gray} in repo: %F{yellow}%1~\
%F{gray} on %F{red}$(git rev-parse --abbrev-ref HEAD 2>/dev/null)";
# %F{gray}[%F{orange}$(git status --porcelain 2>/dev/null)%F{gray}]\
# %F{gray} at %F{blue}%~"
fi)"
  local top_right="%F{white}at %T"
  local bottom_left="$(if [ "$ret" = 0 ]; then
    echo "%F{cyan}$ ";
  else
    echo "%F{red}X ";
fi)%F{white}%b"
  local bottom_right=""

  PROMPT="$(fill-line "$top_left" "$top_right")"$'\n'$bottom_left
  RPROMPT="$bottom_right"
}

TMOUT=120
TRAPALRM() { pipes.sh } # { tock } # { cmatrix -s }

automux() {
  input() {
    read name\?"Enter new session name: ";
    echo "$name";
  }

  session() {
    if [[ -n "$(tmux ls 2>/dev/null | grep -i "windows")" ]]; then
      fzf --layout=reverse --cycle <<< `echo "exit\nnew\n$(tmux ls)"` | awk '{print $1}';
    else
      echo "default";
    fi
  }

  case "$-" in
    *i*)
      if [ -z "$TMUX" ]; then
        local session="$(session)"
        case "$session" in
          "exit")    return;;
          "new")     exec tmux -u new -s "$(input)" ;;
          "default") exec tmux -u new -s "$session" ;;
          *)         exec tmux -u attach -t "$session" ;;
        esac
      else
        local session="$(session)"
        case "$session" in
          "exit") return;;
          "new")  name="$(input)"; tmux new -d -s "$name"; tmux -u switch -t "$name" ;;
          *)      tmux -u switch -t "$session" ;;
        esac
      fi 
    ;;
  esac
}

# Auto start tmux in ssh.
if [[ -n "$SSH_CONNECTION" ]] ; then
  automux
fi

bindkey -s '^n' '^uautomux^m'

if [[ -z "$DISPLAY" ]] ; then
  # Use the custom zsh prompt.
  setterm -blength 0
  set bell-style none

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd set-prompt

  if [[ -z "$TMUX" ]]; then
    file="$(fzf --layout=reverse --cycle <<< `echo "$(/bin/ls ~/.bin/xinit | sort)\ntmux\n$(tty)\npower off\nreboot\nsleep\nlogout"`)"

    case "$file" in
      "logout") exit ;;
      "sleep") systemctl suspend && exit ;;
      "reboot") systemctl reboot ;;
      "power off") systemctl poweroff ;;
      "$(tty)") \clear ;;
      "tmux") exec automux ;;
      *) exec startx ~/.bin/xinit/"$file" ;;
    esac
  fi
else
  # Use the starship prompt.
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"

  # Fetch machine's specs.
  neofetch
fi

# Plugins
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" 2>/dev/null
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" 2>/dev/null
