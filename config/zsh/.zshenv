# [[ $- != *i* ]] && return

source "$ZDOTDIR/env.zsh"

for config in $configs; do
  source "$ZDOTDIR/configs/$config.zsh"
done

[[ -f $XDG_DATA_HOME/.secrets ]] && source $XDG_DATA_HOME/.secrets
