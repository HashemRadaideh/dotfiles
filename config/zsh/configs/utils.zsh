
# Key testing
testkey() {
    xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
}

# Window managers testing utility
testwm() {
    Xephyr :5 -resizeable  & sleep 1 ; DISPLAY=:5 "$1"; # wmctrl -r :5 -e 0,0,0,100,100
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
    if [[ $# -lt 2 ]]; then
        echo "Usage: flash <image_file> <device>" >&2
        return 1
    fi

    local image="$1"
    local device="$2"

    if [[ ! -f "$image" ]]; then
        echo "Error: Image file '$image' not found" >&2
        return 1
    fi

    if [[ ! -b "$device" ]]; then
        echo "Error: '$device' is not a block device" >&2
        return 1
    fi

    notify-send "Flashing $image to $device..."
    if sudo dd bs=4M if="$image" of="$device" conv=fdatasync status=progress; then
        notify-send "Successfully flashed $device"
    else
        notify-send "Failed to flash $device" -u critical
        return 1
    fi
}

lookfor() {
    fd -H "$1" . /
}

mk() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: mk <file_or_dir>" >&2
        return 1
    fi

    local target="$1"

    # If ends with /, create directory
    if [[ "${target: -1}" == "/" ]]; then
        mkdir -p "$target"
        return $?
    fi

    # If contains /, create parent dirs and file
    if [[ "$target" == */* ]]; then
        local dir
        dir=$(dirname -- "$target")
        mkdir -p "$dir" && touch "$target"
        return $?
    fi

    # Otherwise, just create file
    touch "$target"
    return $?
}
