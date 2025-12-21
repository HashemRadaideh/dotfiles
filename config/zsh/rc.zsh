zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

function theme() {
    if [[ -z "$DISPLAY" ]] ; then
        # [ -x "$(command -v pfetch)"  ] && pfetch

        source "$ZDOTDIR/configs/prompt.zsh"
    else
        # [ -x "$(command -v macchina)"  ] && ~/Workspace/art/art > /tmp/ascii && macchina -t Cobalt
        # [ -x "$(command -v macchina)"  ] && macchina

        source "$ZDOTDIR/configs/starship.zsh"
    fi
}

theme

function python-venv() {
    local MYVENV=
    local current_dir="$PWD"

    while [[ "$current_dir" != "/" ]]; do
        for dir in "$current_dir" "$current_dir"/.venv "$current_dir"/venv "$current_dir"/env; do
            if [[ -f "$dir/pyvenv.cfg" ]]; then
                MYVENV="$dir"
                break 2
            fi
        done

        current_dir="$(dirname "$current_dir")"
    done

    if [[ -d "$MYVENV" ]]; then
        if [[ "$MYVENV" != "$VIRTUAL_ENV" ]]; then
            source "$MYVENV/bin/activate" > /dev/null 2>&1
        fi
    else
        [[ -n "$VIRTUAL_ENV" ]] && deactivate > /dev/null 2>&1
        theme
    fi

    if [[ -d "$VIRTUAL_ENV" ]]; then
        if [[ -z "$_PYTHON_VERSION" ]]; then
            _PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")' 2>/dev/null)
        fi

        if [[ -n "$_PYTHON_VERSION" && -d "$VIRTUAL_ENV/lib/python$_PYTHON_VERSION/site-packages" ]]; then
            export PYTHONPATH="$VIRTUAL_ENV/lib/python$_PYTHON_VERSION/site-packages"
        fi
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python-venv
python-venv

function sync_display_from_tmux() {
    [[ -n "$TMUX" ]] || return 0

    if [[ -n "$DISPLAY" && "$_LAST_DISPLAY" != "$DISPLAY" ]]; then
        if ! xdpyinfo >/dev/null 2>&1; then
            local new_display
            new_display=$(tmux show-environment DISPLAY 2>/dev/null | cut -d= -f2)
            [[ -n "$new_display" ]] && export DISPLAY="$new_display"
        fi
        _LAST_DISPLAY="$DISPLAY"
    fi
}

add-zsh-hook precmd sync_display_from_tmux

# if type clipcat-menu >/dev/null 2>&1; then
#     alias clipedit=' clipcat-menu --finder=builtin edit'
#     alias clipdel=' clipcat-menu --finder=builtin remove'

#     bindkey -s '^\' "^Q clipcat-menu --finder=builtin insert ^m"
#     bindkey -s '^]' "^Q clipcat-menu --finder=builtin remove ^m"
# fi

# if [ -t 1 ] && [[ -z "$TMUX" ]]; then
#     TMOUT=300

#     TRAPALRM() { cmatrix -s } # tock # pipes.sh | tock | cmatrix -s | asciiquarium

#     # # trap "cmatrix -s" ALRM

#     # eval `ttysvr logo --init 3`
# fi

autoload -Uz bashcompinit && bashcompinit

autoload -Uz compinit
local zcompdump="${XDG_CACHE_HOME}/zsh/.zcompdump"
if [[ -f "$zcompdump" ]] && [[ "$zcompdump" -nt "${ZDOTDIR}/.zshrc" ]]; then
    compinit -d "$zcompdump"
else
    compinit -C -d "$zcompdump"
fi

fpath=($XDG_CACHE_HOME/.cache/zsh/completions $fpath)

eval "$(zoxide init --cmd cd zsh)"

[ -x "$(command -v arduino-cli)" ] && eval "$(arduino-cli completion zsh)"

[ -x "$(command -v atac)" ] && atac completions zsh "$XDG_CACHE_HOME/zsh/completions" >/dev/null

[ -x "$(command -v ng)" ] && source <(ng completion script)

[ -x "$(command -v brew)" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -s "$CARGO_HOME/env" ] && source "$CARGO_HOME/env"

[ -r "$HOME/.opam/opam-init/init.zsh" ] && source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

[[ -d "$PYENV_ROOT/bin" ]] && eval "$(pyenv init - zsh)"

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
