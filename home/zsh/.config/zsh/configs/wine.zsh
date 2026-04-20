if [ ! -x "$(command -v wine)"  ]; then
    return
fi

alias wine="WINARCH=win64 wine"
alias setupwine="WINARCH=win64 winetricks"
