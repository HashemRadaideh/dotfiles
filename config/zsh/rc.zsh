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
    TRAPALRM() { asciiquarium } # pipes.sh | tock | cmatrix -s | asciiquarium
  fi
}
