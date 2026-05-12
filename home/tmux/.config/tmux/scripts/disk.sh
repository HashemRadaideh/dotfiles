#!/bin/bash

PCT=$(df / | awk 'NR==2{gsub(/%/,"",$5); print $5}')
[ -z "$PCT" ] && exit

LOW=$(tmux show-option -gqv "@disk_low")
MED=$(tmux show-option -gqv "@disk_medium")
HIGH=$(tmux show-option -gqv "@disk_high")
STRESS=$(tmux show-option -gqv "@disk_stress")

if [ "$PCT" -ge 95 ]; then
  COLOR="${STRESS:-#e78284}"
elif [ "$PCT" -ge 85 ]; then
  COLOR="${HIGH:-#ef9f76}"
elif [ "$PCT" -ge 70 ]; then
  COLOR="${MED:-#e5c890}"
else
  COLOR="${LOW:-#a6d189}"
fi

ICON=$(tmux show-option -gqv "@disk_icon")

TMPL=$(tmux show-option -gqv "@disk_view_tmpl")
[ -z "$TMPL" ] && TMPL='#[fg=#{disk.color}]#{disk.icon} #{disk.pct}%'
echo "$TMPL" | sed \
  -e "s|#{disk.icon}|${ICON}|g" \
  -e "s|#{disk.color}|${COLOR}|g" \
  -e "s|#{disk.pct}|${PCT}|g"
