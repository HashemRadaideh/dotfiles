configs=(
  aliases
  cmake
  docker
  lf
  nvim
  paru
  utils
  wine
)

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  # zsh-history-substring-search
  # zsh-auto-notify
  # zsh-you-should-use
)

main() {
  require "configs/fzf"

  # Auto start tmux in ssh.
  [ -x "$(command -v fzf)"  ] && [[ -n "$SSH_CONNECTION" ]] && fzt

  if [[ -z "$DISPLAY" ]] ; then
    [ -x "$(command -v fzf)"  ] && fzdm

    # Use the custom zsh prompt.
    require "configs/prompt" && hash-prompt

    # Fetch machine's specs.
    [ -x "$(command -v pfetch)"  ] && pfetch
  else
    require "configs/starship" && starship-prompt

    # Fetch machine's specs.
    [ -x "$(command -v neofetch)"  ] && neofetch
  fi

  if [[ -z "$TMUX" ]]; then
    TMOUT=120
    TRAPALRM() { asciiquarium }
    # pipes.sh | tock | cmatrix -s | asciiquarium
  fi
}
