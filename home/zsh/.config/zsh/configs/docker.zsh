if [ ! -x "$(command -v docker)"  ]; then
    return
fi

dbuild() {
    docker build -t "$(basename "$(pwd)")" .
}

drun() {
    dbuild "$(basename "$(pwd)")"
    docker run --rm -it --net=host --env="DISPLAY" -v `pwd`:/work $@ "$(basename "$(pwd)")"
}
