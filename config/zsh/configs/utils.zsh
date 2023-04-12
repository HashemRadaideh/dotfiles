
# Key testing
testkey() {
  xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
}

# Window managers testing utility
testwm() {
  Xephyr :5 -resizeable  & sleep 1 ; DISPLAY=:5 "$1" # wmctrl -r :5 -e 0,0,0,100,100
}

testcolors() {
  for x in {0..8}; do 
    for i in {30..37}; do 
      for a in {40..47}; do 
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
      done

      echo
    done
  done
}

flash() {
  notify-send "$1"
  notify-send "$1" -t 5000
  sudo dd bs=4M if="$1" of="$2" conv=fdatasync  status=progress
  notify-send "$2 created successfully"
}
