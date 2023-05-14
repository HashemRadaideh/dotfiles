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
    [ -x "$(command -v neofetch)"  ] && neofetch
  fi
}
