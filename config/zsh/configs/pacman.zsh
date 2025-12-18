# Check for paru (AUR helper) or yay, prefer paru
if [ ! -x "$(command -v paru)" ] && [ ! -x "$(command -v yay)" ]; then
    return
fi

clean() {
    local pkgman='pacman'
    [ -x "$(command -v paru)" ] && pkgman='paru' || [ -x "$(command -v yay)" ] && pkgman='yay'

    local orphans
    if [ "$pkgman" = "paru" ]; then
        orphans=$(paru -Qdtq 2>/dev/null)
    else
        orphans=$(yay -Qdtq 2>/dev/null)
    fi

    if [[ -n "$orphans" ]]; then
        $pkgman -Rcnsdd $orphans && $pkgman -Scc
    else
        $pkgman -Scc
    fi
}

download() {
    local pkgman='pacman'
    [ -x "$(command -v paru)" ] && pkgman='paru' || [ -x "$(command -v yay)" ] && pkgman='yay'

    if $pkgman -S "$@"; then
        local packages_file="${DOTFILES}/scripts/packages.txt"
        [[ -f "$packages_file" ]] || touch "$packages_file" 2>/dev/null

        for item in "$@"; do
            if ! rg -q "^$item$" "$packages_file" 2>/dev/null; then
                echo "$item" >> "$packages_file"
            fi
        done
    fi
}

delete() {
    local pkgman='pacman'
    [ -x "$(command -v paru)" ] && pkgman='paru' || [ -x "$(command -v yay)" ] && pkgman='yay'

    if $pkgman -Rnsdd "$@"; then
        local packages_file="${DOTFILES}/scripts/packages.txt"
        if [[ -f "$packages_file" ]]; then
            for item in "$@"; do
                if rg -q "^$item$" "$packages_file" 2>/dev/null; then
                    sed -i "/^$item$/d" "$packages_file"
                fi
            done
        fi
    fi
}

update() {
    local pkgman='pacman'
    [ -x "$(command -v paru)" ] && pkgman='paru' || [ -x "$(command -v yay)" ] && pkgman='yay'

    $pkgman -Syu

    # Update AUR packages if using AUR helper
    if [[ "$pkgman" != "pacman" ]]; then
        $pkgman -Sua
    fi

    # Update dotfiles repo if it exists and is a git repo
    if [[ -d "$DOTFILES/.git" ]]; then
        (cd "$DOTFILES" && git pull 2>/dev/null)
    fi

    # Update Neovim plugins
    [ -x "$(command -v nvim)" ] && nvim --headless "+Lazy! sync" +qa 2>/dev/null

    # Update Doom Emacs
    [ -x "$(command -v doom)" ] && doom sync 2>/dev/null

    # Update tmux plugins
    if [[ -f ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh ]]; then
        ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh 2>/dev/null
    fi

    # Update rustup
    [ -x "$(command -v rustup)" ] && rustup self upgrade-data 2>/dev/null

    clean

    # Sort and deduplicate packages file
    local packages_file="${DOTFILES}/packages.txt"
    if [[ -f "$packages_file" ]]; then
        sort "$packages_file" | uniq > "${packages_file}.tmp" && mv "${packages_file}.tmp" "$packages_file"
    fi
}
