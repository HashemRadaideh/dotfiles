if [ ! -x "$(command -v docker)"  ]; then
  return
fi

dbuild() {
  docker build -t "$1" .
}

drun() {
  docker run -it --rm -v `pwd`:/work "$1"
}
