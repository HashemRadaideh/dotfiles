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

    # Fetch machine's specs.
    [ -x "$(command -v neofetch)"  ] && macchina
  fi

  # opam configuration
  [[ ! -r /home/hashem/.opam/opam-init/init.zsh ]] || source /home/hashem/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

  python_venv() {
    MYVENV=./.venv
    # when you cd into a folder that contains $MYVENV
    [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
    # when you cd into a folder that doesn't
    [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
  }
  autoload -U add-zsh-hook
  add-zsh-hook chpwd python_venv
}
