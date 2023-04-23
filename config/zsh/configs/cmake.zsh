if [ ! -x "$(command -v cmake)"  ]; then
  return
fi

cbuild() {
  cmake -B ./build && cmake --build ./build $@
}

crun() {
  cbuild "$1"
  if [ $? -eq 0 ]; then
    ./build/"${$(grep -P 'set\(NAME.*' ./CMakeLists.txt | awk '{print $2}')//\)}"
  fi
}

installwm() {
  # build "Release" && sudo cmake --install build/ --prefix "/usr/local/bin"
  cmake -B ./build && sudo cmake --build ./build --config Release --target install
}
