export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTSIZE=1000000
export SAVEHIST="$HISTSIZE"
mkdir -p "${HISTFILE:h}"

export FUNCNEST=100

setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# shellcheck source=/dev/null
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# shellcheck disable=SC2296
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# shellcheck disable=SC2016
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# shellcheck disable=SC2016
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

zstyle ':compinstall' filename "$ZDOTDIR/.zshrc"

# autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit
# shellcheck disable=SC2157
if [[ -n "${ZDOTDIR}/.zcompdump(#qN.mh+24)" ]]; then
  compinit
else
  compinit -C
fi
_comp_options+=(globdots)

zinit light zsh-users/zsh-autosuggestions

# shellcheck disable=SC2016
zinit wait lucid light-mode for \
  Aloxaf/fzf-tab \
  zdharma-continuum/fast-syntax-highlighting \
  olets/zsh-abbr \
  atload'bindkey "${key[Up]}" history-substring-search-up; bindkey "${key[Down]}" history-substring-search-down; bindkey "^K" history-substring-search-up; bindkey "^J" history-substring-search-down' \
  zsh-users/zsh-history-substring-search

zinit wait lucid for \
  OMZP::git \
  OMZP::sudo \
  OMZP::archlinux \
  OMZP::aws \
  OMZP::kubectl \
  OMZP::kubectx \
  OMZP::command-not-found

zinit cdreplay -q

setopt extendedglob nomatch notify autocd interactive_comments
unsetopt beep

stty stop undef

autoload -Uz zmv
autoload -Uz add-zsh-hook

command -v fzf &>/dev/null && eval "$(fzf --zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init --cmd cd zsh)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

source "$ZDOTDIR/configs/nvim.zsh"

if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && -z $SSH_CONNECTION ]]; then
  source "$ZDOTDIR/configs/prompt.zsh"
else
  source "$ZDOTDIR/configs/starship.zsh"
fi

source "$ZDOTDIR/configs/nvm.zsh"
source "$ZDOTDIR/configs/nix.zsh"
source "$ZDOTDIR/configs/python.zsh"
source "$ZDOTDIR/configs/sdkman.zsh"

source "$ZDOTDIR/configs/brew.zsh"

source "$ZDOTDIR/configs/fzf.zsh"
source "$ZDOTDIR/configs/tmux.zsh"
source "$ZDOTDIR/configs/fzt.zsh"
source "$ZDOTDIR/configs/yazi.zsh"
source "$ZDOTDIR/configs/lazygit.zsh"
source "$ZDOTDIR/configs/lazydocker.zsh"

source "$ZDOTDIR/configs/helpers.zsh"
source "$ZDOTDIR/configs/aliases.zsh"
