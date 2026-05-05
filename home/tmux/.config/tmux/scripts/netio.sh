#!/bin/bash

IFACE=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev") {print $(i+1); exit}}')
[ -z "$IFACE" ] && {
  echo "N/A"
  exit
}

TMPFILE="/tmp/tmux_netio_${IFACE}"

read -r RX TX <<<"$(awk -v iface="${IFACE}:" '$1==iface{print $2, $10}' /proc/net/dev)"
[ -z "$RX" ] && {
  echo "N/A"
  exit
}

if [ -f "$TMPFILE" ]; then
  read -r LAST_TIME LAST_RX LAST_TX <"$TMPFILE"
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_TIME))
  if [ "$ELAPSED" -gt 0 ] && [ "$RX" -ge "$LAST_RX" ] && [ "$TX" -ge "$LAST_TX" ]; then
    RX_RATE=$(((RX - LAST_RX) / ELAPSED))
    TX_RATE=$(((TX - LAST_TX) / ELAPSED))
    echo "$NOW $RX $TX" >"$TMPFILE"

    if [ -d "/sys/class/net/$IFACE/wireless" ]; then
      wired=$(tmux show-option -gqv "@net_wired")
      wired="${wired:-#99d1db}"
      sig_high=$(tmux show-option -gqv "@net_wifi_high")
      sig_high="${sig_high:-#99d1db}"
      sig_med=$(tmux show-option -gqv "@net_wifi_medium")
      sig_med="${sig_med:-#e5c890}"
      sig_low=$(tmux show-option -gqv "@net_wifi_low")
      sig_low="${sig_low:-#e78284}"
      signal=$(awk -v iface="${IFACE}:" '$1==iface{gsub(/\./, "", $4); print $4}' /proc/net/wireless 2>/dev/null)
      if [ -z "$signal" ]; then
        IFACE_ICON="󰤫"
      elif [ "$signal" -ge -50 ]; then
        IFACE_ICON="#[fg=${sig_high}]󰤨"
      elif [ "$signal" -ge -60 ]; then
        IFACE_ICON="#[fg=${sig_high}]󰤥"
      elif [ "$signal" -ge -70 ]; then
        IFACE_ICON="#[fg=${sig_med}]󰤢"
      elif [ "$signal" -ge -80 ]; then
        IFACE_ICON="#[fg=${sig_low}]󰤟"
      else
        IFACE_ICON="#[fg=${sig_low}]󰤯"
      fi
    else
      IFACE_ICON="#[fg=${wired}]󰈀"
    fi

    RX_COLOR=$(tmux show-option -gqv "@net_rx_color")
    RX_COLOR="${RX_COLOR:-#99d1db}"
    RX_ICON=$(tmux show-option -gqv "@net_rx_icon")
    RX_ICON="${RX_ICON:-↓}"
    TX_COLOR=$(tmux show-option -gqv "@net_tx_color")
    TX_COLOR="${TX_COLOR:-#ef9f76}"
    TX_ICON=$(tmux show-option -gqv "@net_tx_icon")
    TX_ICON="${TX_icon:-↑}"

    RX_VAL=$(awk -v r="$RX_RATE" 'BEGIN{
      if      (r >= 1048576) printf "%.1fM", r/1048576
      else if (r >= 1024)    printf "%.0fK", r/1024
      else                   printf "%dB",   r
    }')
    TX_VAL=$(awk -v t="$TX_RATE" 'BEGIN{
      if      (t >= 1048576) printf "%.1fM", t/1048576
      else if (t >= 1024)    printf "%.0fK", t/1024
      else                   printf "%dB",   t
    }')

    TMPL=$(tmux show-option -gqv "@net_view_tmpl")
    [ -z "$TMPL" ] && TMPL='#{net.iface} #[fg=#{net.rx_color}]#{net.rx_icon}#{net.rx} #[fg=#{net.tx_color}]#{net.tx_icon}#{net.tx}'
    echo "$TMPL" | sed \
      -e "s|#{net.iface}|${IFACE_ICON}|g" \
      -e "s|#{net.rx_color}|${RX_COLOR}|g" \
      -e "s|#{net.rx_icon}|${RX_ICON}|g" \
      -e "s|#{net.rx}|${RX_VAL}|g" \
      -e "s|#{net.tx_color}|${TX_COLOR}|g" \
      -e "s|#{net.tx_icon}|${TX_ICON}|g" \
      -e "s|#{net.tx}|${TX_VAL}|g"
    exit
  fi
fi

NOW=$(date +%s)
echo "$NOW $RX $TX" >"$TMPFILE"
echo "..."
