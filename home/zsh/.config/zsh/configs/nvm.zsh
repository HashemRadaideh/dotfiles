_nvm_dir="${NVM_DIR:-$XDG_DATA_HOME/nvm}"
if [[ -s "$_nvm_dir/nvm.sh" ]]; then
  _nvm_load() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    # shellcheck source=/dev/null
    source "$_nvm_dir/nvm.sh"
    # shellcheck source=/dev/null
    [[ -s "$_nvm_dir/bash_completion" ]] && source "$_nvm_dir/bash_completion"
  }
  nvm() {
    _nvm_load
    nvm "$@"
  }
  node() {
    _nvm_load
    node "$@"
  }
  npm() {
    _nvm_load
    npm "$@"
  }
  npx() {
    _nvm_load
    npx "$@"
  }
fi

nvm-hook() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.nvmrc" ]]; then
      if [[ "$_NVM_HOOK_DIR" != "$dir" ]]; then
        _NVM_HOOK_DIR="$dir"
        nvm use 2>/dev/null
      fi
      return
    fi
    dir="${dir:h}"
  done

  if [[ -n "$_NVM_HOOK_DIR" ]]; then
    unset _NVM_HOOK_DIR
    nvm use default 2>/dev/null
  fi
}

add-zsh-hook chpwd nvm-hook
nvm-hook
