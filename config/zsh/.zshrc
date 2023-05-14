# Zsh config file (zshrc without oh-my-zsh)
source "$ZDOTDIR/rc.zsh"

zrc

# Completion engine setup
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' glob 'x == 2'
zstyle ':completion:*' matcher-list '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' max-errors 5 numeric
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

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
zle-keymap-select () {
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
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

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

for plugin in $plugins; do
  require "plugins/$plugin/$plugin.plugin"
done

require "plugins/conf"

if [[ -z "$DISPLAY" ]] ; then
  # Use the custom zsh prompt.
  autoload -U colors && colors

  zle-line-init() {
    emulate -L zsh

    [[ $CONTEXT == start ]] || return 0

    while true; do
      zle .recursive-edit
      local -i ret=$?
      [[ $ret == 0 && $KEYS == $'\4' ]] || break
      [[ -o ignore_eof ]] || exit 0
    done

    local saved_prompt=$PROMPT
    local saved_rprompt=$RPROMPT
    
    PROMPT='%~>'
    RPROMPT=''
    zle .reset-prompt
    PROMPT=$saved_prompt
    RPROMPT=$saved_rprompt

    if (( ret )); then
      zle .send-break
    else
      zle .accept-line
    fi
    return ret
  }

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

  zle -N zle-line-init
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd set-prompt
else
  zle-line-init() {
    emulate -L zsh

    [[ $CONTEXT == start ]] || return 0

    while true; do
      zle .recursive-edit
      local -i ret=$?
      [[ $ret == 0 && $KEYS == $'\4' ]] || break
      [[ -o ignore_eof ]] || exit 0
    done

    local saved_prompt=$PROMPT
    local saved_rprompt=$RPROMPT
    PROMPT='$(STARSHIP_CONFIG="$DOTFILES/config/starship/transient.toml" starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
    RPROMPT=''
    zle .reset-prompt
    PROMPT=$saved_prompt
    RPROMPT=$saved_rprompt

    if (( ret )); then
      zle .send-break
    else
      zle .accept-line
    fi
    return ret
  }

  zle -N zle-line-init
fi

if [[ -z "$TMUX" ]]; then
  TMOUT=120
  TRAPALRM() { pipes.sh } # pipes.sh | tock | cmatrix -s | asciiquarium
fi
