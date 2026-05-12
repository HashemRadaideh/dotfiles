#!/bin/bash

TEMP=""
for f in /sys/class/hwmon/hwmon*/temp*_input; do
  label="${f%_input}_label"
  if [ -f "$label" ] && grep -qiE 'package|cpu|tdie' "$label" 2>/dev/null; then
    TEMP=$(cat "$f" 2>/dev/null)
    break
  fi
done

[ -z "$TEMP" ] && TEMP=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
[ -z "$TEMP" ] && exit

FREEZING=$(tmux show-option -gqv "@temp_freezing")
LOW=$(tmux show-option -gqv "@temp_low")
MED=$(tmux show-option -gqv "@temp_medium")
HIGH=$(tmux show-option -gqv "@temp_high")
STRESS=$(tmux show-option -gqv "@temp_stress")

DEG=$((TEMP / 1000))
if [ "$DEG" -ge 85 ]; then
  COLOR="${STRESS:-#e78284}"
  ICON=""
elif [ "$DEG" -ge 70 ]; then
  COLOR="${HIGH:-#ef9f76}"
  ICON=""
elif [ "$DEG" -ge 50 ]; then
  COLOR="${MED:-#e5c890}"
  ICON=""
elif [ "$DEG" -ge 30 ]; then
  COLOR="${LOW:-#a6d189}"
  ICON=""
else
  COLOR="${FREEZING:-#99d1db}"
  ICON=""
fi

UNIT=$(tmux show-option -gqv "@temp_unit")
case "${UNIT:-celsius}" in
fahrenheit)
  UNIT_ICON=$(tmux show-option -gqv "@temp_feh_icon")
  UNIT_ICON="${UNIT_ICON:-°F}"
  DISPLAY_DEG=$((DEG * 9 / 5 + 32))
  ;;
kelvin)
  UNIT_ICON=$(tmux show-option -gqv "@temp_kel_icon")
  UNIT_ICON="${UNIT_ICON:-°K}"
  DISPLAY_DEG=$((DEG + 273))
  ;;
*)
  UNIT_ICON=$(tmux show-option -gqv "@temp_cel_icon")
  UNIT_ICON="${UNIT_ICON:-°C}"
  DISPLAY_DEG="$DEG"
  ;;
esac

TMPL=$(tmux show-option -gqv "@temp_view_tmpl")
[ -z "$TMPL" ] && TMPL='#[fg=#{temp.color}]#{temp.icon} #{temp.deg}#{temp.unit}'
echo "$TMPL" | sed \
  -e "s|#{temp.color}|${COLOR}|g" \
  -e "s|#{temp.icon}|${ICON}|g" \
  -e "s|#{temp.deg}|${DISPLAY_DEG}|g" \
  -e "s|#{temp.unit}|${UNIT_ICON}|g"
