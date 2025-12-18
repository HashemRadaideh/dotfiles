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

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export SDL_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export GLFW_IM_MODULE=ibus

export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:="$HOME/Desktop"}
export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:="$HOME/Documents"}
export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:="$HOME/Downloads"}
export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:="$HOME/Music"}
export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:="$HOME/Pictures"}
export XDG_PUBLICSHARE_DIR=${XDG_PUBLICSHARE_DIR:="$HOME/Public"}
export XDG_TEMPLATES_DIR=${XDG_TEMPLATES_DIR:="$HOME/Templates"}
export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:="$HOME/Videos"}

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

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GTK_THEME='Colloid-Dark-Catppuccin:dark'
export QT_QPA_PLATFORM="xcb"
export QT_QPA_PLATFORMTHEME="qt6ct"
# export QT_STYLE_OVERRIDE="kvantum"

# export _JAVA_OPTIONS="-Djava.io.tmpdir=$XDG_CONFIG_HOME/java -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_USER_HOME="$HOME/.android"
export ANDROID_AVD_HOME="$ANDROID_USER_HOME/avd"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk-bundle"
export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=20
export CHROME_EXECUTABLE=google-chrome-stable
export NDK_HOME=$ANDROID_NDK_HOME
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export NVM_DIR="${NVM_DIR:-$XDG_DATA_HOME/nvm}"
# export GEM_HOME="$(gem env user_gemhome)"
export GEM_HOME="${GEM_HOME:-$HOME/.gem}"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
export WINEPREFIX="$HOME/wine"
export QSYS_ROOTDIR="$XDG_CACHE_HOME/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"
export ATAC_KEY_BINDINGS="$XDG_CONFIG_HOME/atac-config/bindings.toml"
export GNUPGHOME="$XDG_DATA_HOME/gnupm"

add_to_path() {
    [[ -d "$1" || -n "$1" ]] && export PATH="$PATH:$1"
}

add_to_path "$XDG_DATA_HOME/scripts"
add_to_path "$XDG_DATA_HOME/sessions"
add_to_path "$CARGO_HOME/bin"
add_to_path "$GOPATH/bin"
add_to_path "$PYENV_ROOT/bin"
add_to_path "$GEM_HOME/bin"
add_to_path "$XDG_CACHE_HOME/.bun/bin"
add_to_path "$HOME/.yarn/bin"
add_to_path "$HOME/.ghcup/bin"
add_to_path "$HOME/.dotnet/tools"
add_to_path "/home/linuxbrew/.linuxbrew/bin"
add_to_path "/usr/lib/jvm/default/bin"
add_to_path "$XDG_DATA_HOME/nvim/mason/bin"
add_to_path "$XDG_DATA_HOME/JetBrains/Toolbox/bin"
add_to_path "$XDG_DATA_HOME/JetBrains/Toolbox/scripts"
add_to_path "$XDG_CONFIG_HOME/doom/bin"
add_to_path "$XDG_CONFIG_HOME/emacs/bin"
add_to_path "$HOME/.opencode/bin"
