if [ ! -x "$(command -v fzf)"  ]; then
    return
fi

eval "${fzf --zsh}"

# source /usr/share/fzf/completion.zsh
# source /usr/share/fzf/key-bindings.zsh

export FZF_DEFAULT_OPTS='--height=~50% --layout=reverse --border --cycle --preview="bat --decorations=always --color=always {} 2>/dev/null" --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down --exit-0'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude .cache'

ff() {
    temp=`fzf --prompt='Edit:'`
    if [[ "$temp" == "." ]]; then
        cd
    fi

    if [[ -n "$temp" ]]; then
        if  [ -d "$temp" ]; then
            cd "$temp"
        else
            cd "$(sed 's/\(.*\)\/.*/\1/' <<< "$temp")" && "$EDITOR" "$(sed 's/.*\/\(.*\)/\1/' <<< "$temp")"
        fi
    fi
}

bindkey -s '^f' '^uff^m'
