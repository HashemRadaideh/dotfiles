bindkey -v
export KEYTIMEOUT=1

block() { echo -ne '\e[1 q'; }
beam() { echo -ne '\e[5 q'; }

zle-keymap-select() {
  case $KEYMAP in
  vicmd) block ;;
  *) beam ;;
  esac
}
zle-line-init() { beam; }
zle -N zle-keymap-select
zle -N zle-line-init
