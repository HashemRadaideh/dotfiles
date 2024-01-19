plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  # zsh-auto-notify
  # zsh-you-should-use
)

zrc() {
  [ -x "$(command -v gh)"  ] && eval "$(gh completion -s zsh)"

  [ -x "$(command -v zoxide)"  ] && eval "$(zoxide init zsh)"

  if [[ -z "$DISPLAY" ]] ; then
    # Fetch machine's specs.
    [ -x "$(command -v pfetch)"  ] && pfetch
  else
    # Use the starship prompt.
    export STARSHIP_CONFIG="$DOTFILES/config/starship/starship.toml"
    eval "$(starship init zsh)"
    eval "$(flutter bash-completion)"

    # # Fetch machine's specs.
    [ -x "$(command -v macchina)"  ] && ~/art > /tmp/ascii && macchina
    # [ -x "$(command -v macchina)"  ] && macchina

    # kitty +kitten icat --place "50x50@-1x-1" "$(find ~/Pictures/wallpapers/ -type f -exec file -- {} + | awk -F':' '/\w+ image/{print $1}' | shuf -n 1)"
  fi

  # opam configuration
  [[ ! -r /home/hashem/.opam/opam-init/init.zsh ]] || source /home/hashem/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

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
}
