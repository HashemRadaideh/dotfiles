# Home directory clean up

# XDG Variables
export XDG_DATA_HOME="$HOME/.local/bin/"
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_STATE_HOME="$HOME/.local/state/"
export XDG_CACHE_HOME="$HOME/.cache/"

export ANDROID_HOME="$XDG_DATA_HOME/android"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

# export GNUPGHOME="$XDG_DATA_HOME"/gnupg

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# export _JAVA_OPTIONS=-Djava.io.tmpdir="$XDG_CONFIG_HOME"/java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_RUNTIME_DIR/java"

export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"

export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

export prefix=${XDG_DATA_HOME}/npm
export cache=${XDG_CACHE_HOME}/npm
export tmp=${XDG_RUNTIME_DIR}/npm

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# export WINEPREFIX="$HOME/wine"

# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

alias feh='feh --no-fehbg'

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
