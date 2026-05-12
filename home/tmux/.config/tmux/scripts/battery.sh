#!/bin/bash

BAT_PATH=""
for p in /sys/class/power_supply/BAT{0,1,2}; do
  [ -d "$p" ] && {
    BAT_PATH="$p"
    break
  }
done

ENABLED=$(tmux show-option -gqv "@bat_enabled")
ENABLED="${ENABLED:-auto}"

case "$ENABLED" in
off) exit ;;
auto) [ -z "$BAT_PATH" ] && exit ;;
esac
[ -z "$BAT_PATH" ] && exit

PCT=$(cat "$BAT_PATH/capacity" 2>/dev/null)
STATUS=$(cat "$BAT_PATH/status" 2>/dev/null)
[ -z "$PCT" ] && exit

LOW=$(tmux show-option -gqv "@bat_low")
MED=$(tmux show-option -gqv "@bat_med")
HIGH=$(tmux show-option -gqv "@bat_high")
CHARGING_COLOR=$(tmux show-option -gqv "@bat_charging")
CHARGED_COLOR=$(tmux show-option -gqv "@bat_charged")

discharge_icon() {
  if [ "$1" -ge 95 ]; then
    echo "󰁹"
  elif [ "$1" -ge 85 ]; then
    echo "󰂂"
  elif [ "$1" -ge 75 ]; then
    echo "󰂁"
  elif [ "$1" -ge 65 ]; then
    echo "󰂀"
  elif [ "$1" -ge 55 ]; then
    echo "󰁿"
  elif [ "$1" -ge 45 ]; then
    echo "󰁾"
  elif [ "$1" -ge 35 ]; then
    echo "󰁽"
  elif [ "$1" -ge 25 ]; then
    echo "󰁼"
  elif [ "$1" -ge 15 ]; then
    echo "󰁻"
  elif [ "$1" -ge 5 ]; then
    echo "󰁺"
  else
    echo "󰂎"
  fi
}

charge_icon() {
  if [ "$1" -ge 95 ]; then
    echo "󰂄"
  elif [ "$1" -ge 85 ]; then
    echo "󰂋"
  elif [ "$1" -ge 75 ]; then
    echo "󰂊"
  elif [ "$1" -ge 65 ]; then
    echo "󰢞"
  elif [ "$1" -ge 55 ]; then
    echo "󰂉"
  elif [ "$1" -ge 45 ]; then
    echo "󰢝"
  elif [ "$1" -ge 35 ]; then
    echo "󰂈"
  elif [ "$1" -ge 25 ]; then
    echo "󰂇"
  elif [ "$1" -ge 15 ]; then
    echo "󰂅"
  else
    echo "󰢜"
  fi
}

case "$STATUS" in
Charging)
  COLOR="${CHARGING_COLOR:-#e5c890}"
  ICON=$(charge_icon "$PCT")
  ;;
Full | "Not charging")
  COLOR="${CHARGED_COLOR:-#8caaee}"
  ICON=""
  ;;
*)
  ICON=$(discharge_icon "$PCT")
  if [ "$PCT" -le 15 ]; then
    COLOR="${LOW:-#e78284}"
  elif [ "$PCT" -le 40 ]; then
    COLOR="${MED:-#ef9f76}"
  else
    COLOR="${HIGH:-#a6d189}"
  fi
  ;;
esac

TMPL=$(tmux show-option -gqv "@bat_view_tmpl")
[ -z "$TMPL" ] && TMPL='#[fg=#{bat.color}]#{bat.icon} #{bat.pct}%'
echo "$TMPL" | sed \
  -e "s|#{bat.color}|${COLOR}|g" \
  -e "s|#{bat.icon}|${ICON}|g" \
  -e "s|#{bat.pct}|${PCT}|g"
