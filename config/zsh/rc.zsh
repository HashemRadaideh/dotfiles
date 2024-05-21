plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    # zsh-auto-notify
    # zsh-you-should-use
)

zrc() {
    if [[ -z "$DISPLAY" ]] ; then
        # Fetch machine's specs.
        [ -x "$(command -v pfetch)"  ] && pfetch
    else
        # Use the starship prompt.
        export STARSHIP_CONFIG="$DOTFILES/config/starship/starship.toml"
        eval "$(starship init zsh)"

        # # Fetch machine's specs.
        # kitty +kitten icat --place "50x50@-1x-1" "$(find ~/Pictures/wallpapers/ -type f -exec file -- {} + | awk -F':' '/\w+ image/{print $1}' | shuf -n 1)"
        # [ -x "$(command -v macchina)"  ] && ~/art > /tmp/ascii && macchina
        [ -x "$(command -v macchina)"  ] && touch /tmp/ascii && macchina
    fi

    # opam configuration
    [[ ! -r /home/hashem/.opam/opam-init/init.zsh ]] || source /home/hashem/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

    [ -x "$(command -v gh)" ] && eval "$(gh completion -s zsh)"

    # [ -x "$(command -v git)" ] && source "/usr/share/bash-completion/completions/git"

    [ -x "$(command -v zoxide)" ] && eval "$(zoxide init --cmd cd zsh)"

    [ -x "$(command -v flutter)" ] && eval "$(flutter bash-completion)"

    python-venv() {
        local MYVENV=
        local current_dir="$(pwd)"

        while [ "$current_dir" != "/" ]; do
            while IFS= read -r -d '' dir; do
                if [ -f "$dir/pyvenv.cfg" ]; then
                    MYVENV="$dir"
                    break
                fi
            done < <(find "$current_dir" -maxdepth 1 -type d -print0)

            [[ -d $MYVENV ]] && break

            current_dir="$(dirname "$current_dir")"
        done

        [[ -d "$MYVENV" ]] && source "$MYVENV/bin/activate" > /dev/null 2>&1

        [[ ! -d "$MYVENV" ]] && deactivate > /dev/null 2>&1
    }
    autoload -U add-zsh-hook
    add-zsh-hook chpwd python-venv

    if type clipcat-menu >/dev/null 2>&1; then
        alias clipedit=' clipcat-menu --finder=builtin edit'
        alias clipdel=' clipcat-menu --finder=builtin remove'

        bindkey -s '^\' "^Q clipcat-menu --finder=builtin insert ^m"
        bindkey -s '^]' "^Q clipcat-menu --finder=builtin remove ^m"
    fi
}
