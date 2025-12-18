autoload -U colors && colors

# Set up cursor shape for vi mode (if not already set by starship)
if ! (( ${+functions[zle-keymap-select-cursor]} )); then
    zle-keymap-select-cursor() {
        case "$KEYMAP" in
            vicmd) echo -ne '\e[1 q' ;;      # block
            viins|main) echo -ne '\e[5 q' ;; # beam
        esac
    }
fi
zle -N zle-keymap-select zle-keymap-select-cursor

zle-line-init() {
    emulate -L zsh

    # Set vi insert mode and cursor shape (from .zshrc)
    zle -K viins
    echo -ne "\e[5 q"

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
    local top_left="%B%F{yellow}%n$(if [[ -n $SSH_CONNECTION ]]; then echo "%F{gray}@%F{blue}%M"; fi)$(if [[ -z $(git rev-parse --abbrev-ref HEAD 2>/dev/null) ]]; then echo '%F{gray} in %F{magenta}%~'; else echo "%F{gray} in repo: %F{yellow}%1~%F{gray} on %F{red}$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"; fi)"
    # %F{gray}[%F{orange}$(git status --porcelain 2>/dev/null)%F{gray}]\
        # %F{gray} at %F{blue}%~"
    local top_right="%F{white}at %T"
    local bottom_left="$(if [ "$ret" = 0 ]; then echo "%F{cyan}$ "; else echo "%F{red}X "; fi)%F{white}%b"
    local bottom_right=""

    PROMPT="$(fill-line "$top_left" "$top_right")"$'\n'$bottom_left
    RPROMPT="$bottom_right"
}

zle -N zle-line-init
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
