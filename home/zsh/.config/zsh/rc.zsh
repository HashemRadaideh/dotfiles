zinit wait lucid light-mode for \
  Aloxaf/fzf-tab \
  atload'bindkey "${terminfo[kbs]}" autopair-delete; bindkey "^H" autopair-delete-word' \
  hlissner/zsh-autopair \
  zsh-users/zsh-history-substring-search \
  zdharma-continuum/fast-syntax-highlighting \
  kutsan/zsh-system-clipboard \
  olets/zsh-abbr \
  Tarrasch/zsh-autoenv \
  lukechilds/zsh-nvm

zinit wait lucid for \
  OMZP::git \
  OMZP::sudo \
  OMZP::archlinux \
  OMZP::aws \
  OMZP::kubectl \
  OMZP::kubectx \
  OMZP::bgnotify

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light romkatv/zsh-defer

# autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit
zcompdump="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
if [[ ! -f "$zcompdump" ]] || [[ -n "$(find "$zcompdump" -mmin +1440 2>/dev/null)" ]]; then
  compinit -d "$zcompdump"
else
  compinit -C -d "$zcompdump"
fi
_comp_options+=(globdots)

zinit cdreplay -q

export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTSIZE=1000000
export SAVEHIST="$HISTSIZE"
mkdir -p "${HISTFILE:h}"

setopt appendhistory sharehistory extended_history hist_save_no_dups hist_find_no_dups hist_expire_dups_first hist_ignore_space hist_ignore_dups hist_ignore_all_dups extendedglob nomatch notify autocd interactive_comments
unsetopt beep

stty stop undef

export WORDCHARS=${WORDCHARS//[\/]/}

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

command -v zoxide &>/dev/null && eval "$(zoxide init --cmd cd zsh)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
command -v fzf &>/dev/null && eval "$(fzf --zsh)"
command -v atuin &>/dev/null && eval "$(atuin init zsh)"

source "$ZDOTDIR/configs/vi.zsh"
source "$ZDOTDIR/configs/starship.zsh"

zsh-defer source "$ZDOTDIR/configs/keybindings.zsh"
zsh-defer source "$ZDOTDIR/configs/aliases.zsh"
zsh-defer source "$ZDOTDIR/configs/helpers.zsh"

zsh-defer source "$ZDOTDIR/configs/nvim.zsh"
zsh-defer source "$ZDOTDIR/configs/tmux.zsh"
zsh-defer source "$ZDOTDIR/configs/yazi.zsh"
zsh-defer source "$ZDOTDIR/configs/fzt.zsh"
zsh-defer source "$ZDOTDIR/configs/lazygit.zsh"
zsh-defer source "$ZDOTDIR/configs/lazydocker.zsh"
zsh-defer source "$ZDOTDIR/configs/ai.zsh"

zsh-defer source "$ZDOTDIR/configs/nix.zsh"
zsh-defer source "$ZDOTDIR/configs/python.zsh"
zsh-defer source "$ZDOTDIR/configs/opam.zsh"
zsh-defer source "$ZDOTDIR/configs/brew.zsh"
zsh-defer source "$ZDOTDIR/configs/sdkman.zsh"
