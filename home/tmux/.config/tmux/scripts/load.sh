#!/bin/bash

LOAD=$(uptime | awk -F'average: ' '{print $2}' | cut -d, -f1 | xargs)
CPUS=$(nproc 2>/dev/null || echo 1)
[ -z "$LOAD" ] && exit

LOW=$(tmux show-option -gqv "@load_low")
MED=$(tmux show-option -gqv "@load_medium")
HIGH=$(tmux show-option -gqv "@load_high")
STRESS=$(tmux show-option -gqv "@load_stress")

LEVEL=$(awk -v l="$LOAD" -v c="$CPUS" 'BEGIN{
    r = l / c
    if      (r >= 1.0) print "stress"
    else if (r >= 0.7) print "high"
    else if (r >= 0.4) print "medium"
    else               print "low"
}')

case "$LEVEL" in
stress) COLOR="${STRESS:-#e78284}" ;;
high) COLOR="${HIGH:-#ef9f76}" ;;
medium) COLOR="${MED:-#e5c890}" ;;
*) COLOR="${LOW:-#a6d189}" ;;
esac

ICON=$(tmux show-option -gqv "@load_icon")

TMPL=$(tmux show-option -gqv "@load_view_tmpl")
[ -z "$TMPL" ] && TMPL='#[fg=#{load.color}]#{load.icon} #{load.val}'
echo "$TMPL" | sed \
  -e "s|#{load.icon}|${ICON}|g" \
  -e "s|#{load.color}|${COLOR}|g" \
  -e "s|#{load.val}|${LOAD}|g"
