typeset -g -A key

# shellcheck disable=SC2154
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Control-Backspace]='^H'
key[Control-Delete]="${terminfo[kDC5]}"
key[Insert]="${terminfo[kich1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

[[ -n "${key[Backspace]}" ]]        && bindkey -- "${key[Backspace]}"        backward-delete-char
[[ -n "${key[Delete]}" ]]           && bindkey -- "${key[Delete]}"           delete-char
[[ -n "${key[Home]}" ]]             && bindkey -- "${key[Home]}"             beginning-of-line
[[ -n "${key[End]}" ]]              && bindkey -- "${key[End]}"              end-of-line
[[ -n "${key[Up]}" ]]               && bindkey -- "${key[Up]}"               up-line-or-history
[[ -n "${key[Down]}" ]]             && bindkey -- "${key[Down]}"             down-line-or-history
[[ -n "${key[Left]}" ]]             && bindkey -- "${key[Left]}"             backward-char
[[ -n "${key[Right]}" ]]            && bindkey -- "${key[Right]}"            forward-char
[[ -n "${key[Control-Left]}" ]]     && bindkey -- "${key[Control-Left]}"     backward-word
[[ -n "${key[Control-Right]}" ]]    && bindkey -- "${key[Control-Right]}"    forward-word
[[ -n "${key[Control-Backspace]}" ]] && bindkey -M viins -- "${key[Control-Backspace]}" backward-kill-word
[[ -n "${key[Control-Delete]}" ]]   && bindkey -M viins -- "${key[Control-Delete]}"    kill-word
[[ -n "${key[Insert]}" ]]           && bindkey -- "${key[Insert]}"           overwrite-mode
[[ -n "${key[PageUp]}" ]]           && bindkey -- "${key[PageUp]}"           beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]         && bindkey -- "${key[PageDown]}"         end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]]        && bindkey -- "${key[Shift-Tab]}"        reverse-menu-complete

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  zle_application_mode_start() { echoti smkx; }
  zle_application_mode_stop() { echoti rmkx; }
  add-zle-hook-widget -Uz zle-line-init   zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^z' undo
bindkey '^y' redo
bindkey ' '  magic-space

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
