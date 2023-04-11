alias newvim="NVIM_APPNAME=NewNvim nvim"

nvims() {
  items=("Default" "NewVim")
  config=$(printf "%s\n" "${itmes[@]}" | fzf --prompt="Neovim config: " --height=~50% --layout=reverse --border --exit=0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $0
}

bindkey -s ^a "nvims\n"
