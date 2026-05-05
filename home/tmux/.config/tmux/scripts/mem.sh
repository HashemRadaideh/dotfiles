#!/bin/bash

TOTAL_KB=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
AVAIL_KB=$(awk '/^MemAvailable:/{print $2}' /proc/meminfo)
[ -z "$TOTAL_KB" ] && { echo "N/A"; exit; }

USED_KB=$(( TOTAL_KB - AVAIL_KB ))
PCT=$(( USED_KB * 100 / TOTAL_KB ))

fmt_mem() {
  local kb=$1
  if [ "$kb" -ge 1048576 ]; then
    awk -v k="$kb" 'BEGIN{printf "%.1fG", k/1048576}'
  else
    awk -v k="$kb" 'BEGIN{printf "%.0fM", k/1024}'
  fi
}

USED=$(fmt_mem "$USED_KB")
TOTAL=$(fmt_mem "$TOTAL_KB")

LOW=$(tmux show-option -gqv "@mem_low")
MED=$(tmux show-option -gqv "@mem_medium")
STRESS=$(tmux show-option -gqv "@mem_stress")

if [ "$PCT" -ge 90 ]; then
  COLOR="${STRESS:-#e78284}"
elif [ "$PCT" -ge 70 ]; then
  COLOR="${MED:-#e5c890}"
else
  COLOR="${LOW:-#a6d189}"
fi

ICON=$(tmux show-option -gqv "@mem_icon")

TMPL=$(tmux show-option -gqv "@mem_view_tmpl")
[ -z "$TMPL" ] && TMPL='#[fg=#{mem.color}]#{mem.icon} #{mem.pused}'
echo "$TMPL" | sed \
  -e "s|#{mem.icon}|${ICON}|g" \
  -e "s|#{mem.color}|${COLOR}|g" \
  -e "s|#{mem.pused}|${PCT}%|g" \
  -e "s|#{mem.used}|${USED}|g" \
  -e "s|#{mem.total}|${TOTAL}|g"
