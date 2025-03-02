if [ ! -x "$(command -v yay)"  ]; then
    return
fi

clean() {
    local pkgman='pacman'
    [ -x "$(command -v yay)" ] && pkgman='yay'

    $pkgman -Rcnsdd $(yay -Qdtq) && $pkgman -Scc
}

download() {
    local pkgman='pacman'
    [ -x "$(command -v yay)" ] && pkgman='yay'

    $pkgman -S $@

    touch "$DOTFILES/scripts/packages.txt" 2> /dev/null

    if [ $? -eq 0 ]; then
        for item in "$@"; do
            if ! rg -q "^$item$" "$DOTFILES/scripts/packages.txt" ; then
                echo "$item" >> "$DOTFILES/scripts/packages.txt"
            fi
        done
    fi
}

delete() {
    local pkgman='pacman'
    [ -x "$(command -v yay)" ] && pkgman='yay'

    $pkgman -Rnsdd $@

    if [ $? -eq 0 ] && [ -f "$DOTFILES/scripts/packages.txt" ]; then
        for item in "$@"; do
            if rg -q "^$item$" "$DOTFILES/scripts/packages.txt"; then
                sed -i "/^$item$/d" "$DOTFILES/scripts/packages.txt"
            fi
        done
    fi
}

update() {
    local pkgman='pacman'
    [ -x "$(command -v yay)" ] && pkgman='yay'

    $pkgman -Syu

    [ -x "$(command -v yay)" ] && $pkgman -Sua

    reposync  ~/.files/ ~/

    # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    nvim --headless "+Lazy! sync" +qa

    doom sync

    ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh

    rustup self upgrade-data

    clean

    sort "$DOTFILES/packages.txt" | uniq --unique > "$DOTFILES/packages.txt"
}
