configs=(
  cmake
  codi
  docker
  fzf
  git
  lf
  nvim
  paru
  prompt
  starship
  utils
  wine
)

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  # zsh-auto-notify
  # zsh-you-should-use
)

main() {
  eval "$(zoxide init zsh)"

  if [[ -z "$TMUX" ]]; then
    TMOUT=120
    TRAPALRM() { tock }
    # pipes.sh | tock | cmatrix -s | asciiquarium
  fi

  # Auto start tmux in ssh.
  if [[ -n "$SSH_CONNECTION" ]] ; then
    fzt
  fi

  if [[ -z "$DISPLAY" ]] ; then
    fzdm

    # Use the custom zsh prompt.
    autoload -Uz add-zsh-hook
    hash-prompt

    # Fetch machine's specs.
    pfetch
  else
    starship-prompt

    # Fetch machine's specs.
    neofetch
  fi
}
