if [ ! -x "$(command -v yazi)"  ]; then
    return
fi

# yazi change directory to the last visited directory
yazi() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    command yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}


bindkey -s '^o' '^uyazi^m'
