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
    return "$ret"
}

prompt-length() {
    emulate -L zsh
    local -i x y="${#1}" m
    if (( y )); then
        # shellcheck disable=SC2298,SC2296
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
            x=y
            (( y *= 2 ))
        done
        while (( y > x + 1 )); do
            (( m = x + (y - x) / 2 ))
            # shellcheck disable=SC2298,SC2296
            (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
        done
    fi
    echo "$x"
}

fill-line() {
    local left_len
    left_len="$(prompt-length "$1")"
    local right_len
    right_len="$(prompt-length "$2")"
    local pad_len="$((COLUMNS - left_len - right_len - 1))"
    # shellcheck disable=SC2296
    local pad="${(pl.$pad_len.. .)}"
    echo "${1}${pad}${2}"
}

set-prompt() {
    local ret
    ret="$?"
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    local top_left="%B%F{yellow}%n"
    [[ -n "$SSH_CONNECTION" ]] && top_left+="%F{gray}@%F{blue}%M"
    if [[ -n "$branch" ]]; then
        top_left+="%F{gray} in repo: %F{yellow}%1~%F{gray} on %F{red}$branch"
    else
        top_left+="%F{gray} in %F{magenta}%~"
    fi

    local bottom_left
    (( ret == 0 )) && bottom_left="%F{cyan}\$ " || bottom_left="%F{red}X "
    bottom_left+="%F{white}%b"

    local filled
    filled="$(fill-line "$top_left" "%F{white}at %T")"
    PROMPT="${filled}"$'\n'$bottom_left
    RPROMPT=""
}

zle -N zle-line-init
add-zsh-hook precmd set-prompt
