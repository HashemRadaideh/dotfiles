configs=(
    aliases
    cmake
    docker
    fzf
    lf
    nvim
    pacman
    utils
    wine
)

# export CC=`which clang`
# alias cc=`which clang`

# export CXX=`which clang++`
# alias cpp=`which clang++`

function conda-open() {
    eval "$($XDG_DATA_HOME/miniforge3/bin/conda shell.zsh hook)"
}

export TERMINAL="kitty"

# $EDITOR use nvim
export EDITOR="nvim"

visudo() {
    sudo EDITOR=$EDITOR visudo
}

# $FILEMANAGER
export FILEMANAGER="lf"

# git editor
export GIT_EDITOR="$EDITOR"

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# $OPENER use xdg-open
export OPENER="xdg-open"

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
export CHROME_EXECUTABLE=google-chrome-stable
export NDK_HOME=$ANDROID_NDK_HOME
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupm"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK_2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export QT_QPA_PLATFORM="xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
# export QT_STYLE_OVERRIDE="kvantum"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SSB_HOME="$XDG_DATA_HOME"/zoom
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export WINEPREFIX="$HOME/wine"
export QSYS_ROOTDIR="$XDG_CACHE_HOME/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"


export PATH="$PATH:$XDG_DATA_HOME:$XDG_DATA_HOME/scripts:$XDG_DATA_HOME/sessions:$XDG_DATA_HOME/cargo/bin:$GOPATH/bin/:$XDG_CONFIG_HOME/doom/bin:$XDG_CONFIG_HOME/emacs/bin:/usr/lib/jvm/default/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME:$XDG_DATA_HOME/nvim/mason/bin:$HOME/.yarn/bin/:$HOME/.cache/.bun/bin/:$HOME/.ghcup/bin/:$JAVA_HOME"

alias mysql-workbench=mysql-workbench --configdir="$XDG_DATA_HOME/mysql/workbench"
alias yarn='yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config'
alias feh='feh --no-fehbg'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias svn='svn --config-dir $XDG_CONFIG_HOME/subversion'

zenv() { }
