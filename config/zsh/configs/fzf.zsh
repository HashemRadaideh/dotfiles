if [ ! -x "$(command -v fzf)"  ]; then
    return
fi

export FZF_DEFAULT_OPTS='--height=~50% --layout=reverse --border --cycle --preview="bat --decorations=always --color=always {} 2>/dev/null" --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down --exit-0'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude .cache'

ff() {
    local temp
    temp=$(fzf --prompt='Edit:')

    if [[ -z "$temp" ]]; then
        return 0
    fi

    if [[ "$temp" == "." ]]; then
        cd "$HOME"
        return 0
    fi

    if [[ -d "$temp" ]]; then
        cd "$temp"
    else
        local dir file
        dir=$(dirname -- "$temp")
        file=$(basename -- "$temp")
        cd "$dir" && "$EDITOR" "$file"
    fi
}

bindkey -s '^f' '^uff^m'
