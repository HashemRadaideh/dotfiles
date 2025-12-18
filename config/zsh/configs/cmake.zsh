if [ ! -x "$(command -v cmake)"  ]; then
    return
fi

cbuild() {
    cmake -B ./build && cmake --build ./build $@
}

crun() {
    if cbuild "$@"; then
        local name
        name=$(grep -P 'set\(NAME\s+' ./CMakeLists.txt 2>/dev/null | awk '{print $2}' | tr -d ')')
        if [[ -n "$name" && -x "./build/$name" ]]; then
            ./build/"$name"
        else
            echo "Error: Could not find executable name in CMakeLists.txt or binary doesn't exist" >&2
            return 1
        fi
    fi
}

installwm() {
    # build "Release" && sudo cmake --install build/ --prefix "/usr/local/bin"
    cmake -B ./build && sudo cmake --build ./build --config Release --target install
}
