if [[ -t 0 && $- = *i* ]]; then
  # change Ctrl+C to Ctrl+I
  stty start ''
  stty stop ''
  stty quit ''
  stty erase ''
  stty kill ''
  # stty eof '' # Ctrl + D
  stty rprnt ''
  stty werase ''
  stty lnext ''
  stty discard ''
fi

# change Ctrl+C to Ctrl+Q
stty intr '^q'

# change Ctrl+z to Ctrl+j
stty susp '^j'

# change Ctrl+V to Ctrl+K
bindkey '^k' quoted-insert # for zle

_copy-using-xsel() {
  if ((REGION_ACTIVE)) then
    zle copy-region-as-kill
    printf "$CUTBUFFER" | xsel -i --clipboard
    ((REGION_ACTIVE = 0))
  fi
}

zle -N _copy-using-xsel
bindkey '^c' _copy-using-xsel # Copy text

_cut-using-xsel() {
  if ((REGION_ACTIVE)) then
    zle copy-region-as-kill
    printf "$CUTBUFFER" | xsel -i --clipboard
    zle kill-region
  fi
}

zle -N _cut-using-xsel
bindkey '^x' _cut-using-xsel # Cut text

_paste-copy-using-xsel() {
  LBUFFER+="$(xsel -b -o)"
}

zle -N _paste-copy-using-xsel
bindkey '^v' _paste-copy-using-xsel # Paste

