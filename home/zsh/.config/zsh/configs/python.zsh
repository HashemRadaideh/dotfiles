if [[ -d "${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}" ]]; then
  export PYENV_ROOT="${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}"
  path=("${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}/bin" "${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}/shims" "${path[@]}")
  pyenv() {
    unfunction pyenv
    eval "$(pyenv init - zsh)"
    pyenv "$@"
  }
fi

python-venv-hook() {
  if [[ -n "$VIRTUAL_ENV" && "$PWD" != *"${VIRTUAL_ENV:h}"* ]]; then
    deactivate
    return
  fi

  [[ -n "$VIRTUAL_ENV" ]] && return

  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      source "$dir/.venv/bin/activate"
      return
    fi
    dir="${dir:h}"
  done
}

add-zsh-hook chpwd python-venv-hook
python-venv-hook
