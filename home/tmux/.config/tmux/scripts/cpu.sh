#!/bin/bash

TMPFILE="/tmp/tmux_cpu"
NOW=$(date +%s)

read -r _ user nice sys idle iowait irq softirq steal _ _ < /proc/stat
TOTAL=$((user + nice + sys + idle + iowait + irq + softirq + steal))
IDLE=$((idle + iowait))

if [ -f "$TMPFILE" ]; then
  read -r LAST_TIME LAST_TOTAL LAST_IDLE <"$TMPFILE"
  ELAPSED=$((NOW - LAST_TIME))
  if [ "$ELAPSED" -gt 0 ] && [ "$TOTAL" -ge "$LAST_TOTAL" ]; then
    DTOTAL=$((TOTAL - LAST_TOTAL))
    DIDLE=$((IDLE - LAST_IDLE))
    echo "$NOW $TOTAL $IDLE" >"$TMPFILE"

    if [ "$DTOTAL" -gt 0 ]; then
      PCT=$(( (DTOTAL - DIDLE) * 100 / DTOTAL ))
    else
      PCT=0
    fi

    LOW=$(tmux show-option -gqv "@cpu_low")
    MED=$(tmux show-option -gqv "@cpu_medium")
    STRESS=$(tmux show-option -gqv "@cpu_stress")

    if [ "$PCT" -ge 90 ]; then
      COLOR="${STRESS:-#e78284}"
    elif [ "$PCT" -ge 60 ]; then
      COLOR="${MED:-#e5c890}"
    else
      COLOR="${LOW:-#a6d189}"
    fi

    ICON=$(tmux show-option -gqv "@cpu_icon")

    TMPL=$(tmux show-option -gqv "@cpu_view_tmpl")
    [ -z "$TMPL" ] && TMPL='#[fg=#{cpu.color}]#{cpu.icon} #{cpu.pused}'
    echo "$TMPL" | sed \
      -e "s|#{cpu.icon}|${ICON}|g" \
      -e "s|#{cpu.color}|${COLOR}|g" \
      -e "s|#{cpu.pused}|${PCT}%|g"
    exit
  fi
fi

echo "$NOW $TOTAL $IDLE" >"$TMPFILE"
echo "..."
