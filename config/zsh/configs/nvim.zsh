
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
