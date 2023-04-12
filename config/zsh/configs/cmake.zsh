
build() {
  local mode="${1:-Debug}"

  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -B ./build && cmake --build ./build --config "$mode" --target all -j 6 --
}

run() {
  build "$1"
  if [ $? -eq 0 ]; then
    ./build/"${$(grep -P 'set\(NAME.*' ./CMakeLists.txt | awk '{print $2}')//\)}"
  fi
}

installwm() {
  # build "Release" && sudo cmake --install build/ --prefix "/usr/local/bin"
  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -B ./build && sudo cmake --build ./build --config Release --target install
}
