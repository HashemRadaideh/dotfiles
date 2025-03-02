configs=(
    aliases
    cmake
    docker
    fzf
    lf
    yazi
    nvim
    pacman
    utils
    wine
)

# $EDITOR use nvim
export EDITOR="nvim"

# $FILEMANAGER
export FILEMANAGER="lf"

# git editor
export GIT_EDITOR="$EDITOR"

# $OPENER use xdg-open
export OPENER="xdg-open"

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# $PAGER uses bat with colors enabled
export PAGER="bat --decorations=always --color=always --paging=always"

# fix for weird characters in man pages when using bat
export MANROFFOPT='-c'

# $VISUAL uses Emacs in GUI mode
export VISUAL="emacsclient --alternate-editor='emacs' --create-frame"

export DOTFILES="$HOME/.files"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/bin"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

# home directory clean up
# export _JAVA_OPTIONS="-Djava.io.tmpdir=$XDG_CONFIG_HOME/java -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1
# export JAVA_HOME=/opt/android-studio/jbr/bin/
export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_USER_HOME=$HOME/.android
export ANDROID_AVD_HOME=$ANDROID_USER_HOME/avd
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=20
export CHROME_EXECUTABLE=google-chrome-stable
export NDK_HOME=$ANDROID_NDK_HOME
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupm"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GTK_THEME='Colloid-Dark-Catppuccin:dark'
export QT_QPA_PLATFORM="xcb"
export QT_QPA_PLATFORMTHEME="qt6ct"
# export QT_STYLE_OVERRIDE="kvantum"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SSB_HOME="$XDG_DATA_HOME"/zoom
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export WINEPREFIX="$HOME/wine"
export QSYS_ROOTDIR="$XDG_CACHE_HOME/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"

export PATH="$PATH:$XDG_DATA_HOME:$XDG_DATA_HOME/scripts:$XDG_DATA_HOME/sessions:$XDG_DATA_HOME/cargo/bin:$GOPATH/bin/:$XDG_CONFIG_HOME/doom/bin:$XDG_CONFIG_HOME/emacs/bin:/usr/lib/jvm/default/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin/:$ANDROID_NDK_HOME:$XDG_DATA_HOME/nvim/mason/bin:$HOME/.yarn/bin/:$HOME/.cache/.bun/bin/:$HOME/.ghcup/bin/:$JAVA_HOME:$XDG_DATA_HOME/JetBrains/Toolbox/bin:$XDG_DATA_HOME/JetBrains/Toolbox/scripts"
