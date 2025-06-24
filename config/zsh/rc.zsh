# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

theme() {
    if [[ -z "$DISPLAY" ]] ; then
        # Fetch machine's specs.
        # [ -x "$(command -v pfetch)"  ] && pfetch
        source "$ZDOTDIR/configs/prompt.zsh"
    else
        source "$ZDOTDIR/configs/starship.zsh"

        # # Fetch machine's specs.
        # [ -x "$(command -v macchina)"  ] && ~/Workspace/art/art > /tmp/ascii && macchina -t Cobalt
        # [ -x "$(command -v macchina)"  ] && macchina
    fi
}

theme

# Load completions
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Shell integrations
eval "$(fzf --zsh)"

eval "$(zoxide init --cmd cd zsh)"

[ -x "$(command -v arduino-cli)" ] && eval "$(arduino-cli completion zsh)"

[ -x "$(command -v atac)" ] && atac completions zsh $XDG_CACHE_HOME/zsh/completions >/dev/null
fpath=($XDG_CACHE_HOME/.cache/zsh/completions $fpath)

# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

function python-venv() {
    local MYVENV=
    local current_dir="$(pwd)"

    while [ "$current_dir" != "/" ]; do
        while IFS= read -r -d '' dir; do
            if [ -f "$dir/pyvenv.cfg" ]; then
                MYVENV="$dir"
                break
            fi
        done < <(find "$current_dir" -maxdepth 1 -type d -print0)

        [[ -d $MYVENV ]] && break

        current_dir="$(dirname "$current_dir")"
    done

    if [[ -d "$MYVENV" ]]; then
        source "$MYVENV/bin/activate" > /dev/null 2>&1
    else
        deactivate > /dev/null 2>&1
        theme
    fi

    [[ -d "$VIRTUAL_ENV" ]] && export PYTHONPATH="$VIRTUAL_ENV/lib/$(\ls $VIRTUAL_ENV/lib)/site-packages"
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python-venv
python-venv

function sync_display_from_tmux() {
  if [[ -n "$TMUX" && -n "$DISPLAY" ]]; then
    if ! xdpyinfo >/dev/null 2>&1; then
      export DISPLAY=$(tmux show-environment DISPLAY 2>/dev/null | cut -d= -f2)
    fi
  fi
}

add-zsh-hook precmd sync_display_from_tmux

if type clipcat-menu >/dev/null 2>&1; then
    alias clipedit=' clipcat-menu --finder=builtin edit'
    alias clipdel=' clipcat-menu --finder=builtin remove'

    bindkey -s '^\' "^Q clipcat-menu --finder=builtin insert ^m"
    bindkey -s '^]' "^Q clipcat-menu --finder=builtin remove ^m"
fi

# if [ -t 1 ] && [[ -z "$TMUX" ]]; then
#     TMOUT=300

#     TRAPALRM() { cmatrix -s } # tock # pipes.sh | tock | cmatrix -s | asciiquarium

#     # # trap "cmatrix -s" ALRM

#     # eval `ttysvr logo --init 3`
# fi
