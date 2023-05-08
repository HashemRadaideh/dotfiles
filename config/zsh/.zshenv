source "$ZDOTDIR/env.zsh"

require() {
  source "$ZDOTDIR/$1.zsh" 2>/dev/null
}

zenv

for config in $configs; do
  require "configs/$config"
done
