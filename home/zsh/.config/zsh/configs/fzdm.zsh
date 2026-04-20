function fzdm() {
    [ -n "$TMUX" ] && exit

    starter() {
        tmp=$(grep -P 'export XDG_SESSION_TYPE=*' "$XDG_DATA_HOME/sessions/$1" | awk '{print $2}')
        extension="${tmp//\)}"

        if [ "$extension" = "XDG_SESSION_TYPE=x11" ]; then
            startx "$XDG_DATA_HOME/sessions/$1"
        else
            eval "$(\cat "$XDG_DATA_HOME"/sessions/"$1")"
        fi
    }

    list=("$(\ls "$XDG_DATA_HOME/sessions" | sort)" "tmux" "$(tty)" "power off" "reboot" "sleep" "logout")
    file=$(printf "%s\n" "${list[@]}" | fzf --border-label=" Fuzzy Display Manager (fzdm) ")

    [ -z "$file" ] && exit

    case "$file" in
        "logout") exit ;;
        "sleep") systemctl suspend ;;
        "reboot") systemctl reboot ;;
        "power off") systemctl poweroff ;;
        "$(tty)") clear ;;
        "tmux") exec fzt ;;
        *) starter "$file" ;;
    esac
}
