#!/bin/bash

TOTAL_KB=$(awk '/^SwapTotal:/{print $2}' /proc/meminfo)
FREE_KB=$(awk '/^SwapFree:/{print $2}' /proc/meminfo)
[ -z "$TOTAL_KB" ] || [ "$TOTAL_KB" -eq 0 ] && exit

USED_KB=$((TOTAL_KB - FREE_KB))
PCT=$((USED_KB * 100 / TOTAL_KB))

LOW=$(tmux show-option -gqv "@swap_low")
MED=$(tmux show-option -gqv "@swap_medium")
STRESS=$(tmux show-option -gqv "@swap_stress")

if [ "$PCT" -ge 80 ]; then
  COLOR="${STRESS:-#e78284}"
elif [ "$PCT" -ge 40 ]; then
  COLOR="${MED:-#e5c890}"
else
  COLOR="${LOW:-#a6d189}"
fi

ICON=$(tmux show-option -gqv "@swap_icon")

TMPL=$(tmux show-option -gqv "@swap_view_tmpl")
[ -z "$TMPL" ] && TMPL='#[fg=#{swap.color}]#{swap.icon} #{swap.pused}'
echo "$TMPL" | sed \
  -e "s|#{swap.icon}|${ICON}|g" \
  -e "s|#{swap.color}|${COLOR}|g" \
  -e "s|#{swap.pused}|${PCT}%|g"
