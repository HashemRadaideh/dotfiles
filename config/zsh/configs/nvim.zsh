if [ ! -x "$(command -v nvim)"  ]; then
  return
fi

alias nv="nvim"
alias vi="nvim"
alias vim="nvim"

alias newvim="NVIM_APPNAME=nvim-new nvim"

nvims() {
  items=("Default" "nvim-new")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  ")
  if [[ -z "$config" ]]; then
    echo "Nothing selected"
    return 0
  elif [[ "$config" == "Default" ]]; then
    config=""
  fi
  NVIM_APPNAME="$config" nvim "$@"
}

bindkey -s ^a "nvims\n"

codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}
