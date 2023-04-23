if [ ! -x "$(command -v wine)"  ]; then
  return
fi

runwin() {
  WINARCH=win64
  wine "$2"
}

setupwin() {
  WINARCH=win64
  winetricks
}
