
alias newvim="NVIM_APPNAME=nvim-new nvim"

nvims() {
  items=("Default" "nvim-new")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z "$config" ]]; then
    echo "Nothing selected"
    return 0
  elif [[ "$config" == "Default" ]]; then
    config=""
  fi
  NVIM_APPNAME="$config" nvim "$@"
}

bindkey -s ^a "nvims\n"
