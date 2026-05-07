export DOTFILES="$HOME/.files"

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

export EDITOR="nvim"

export GIT_EDITOR="$EDITOR"

export VISUAL="$EDITOR"

export FILEMANAGER="yazi"

export OPENER="xdg-open"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PAGER="bat --decorations=always --color=always --paging=always"

export MANROFFOPT='-c'

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export SDL_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export GLFW_IM_MODULE=ibus

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GTK_THEME='Colloid-Dark-Catppuccin:dark'
export QT_QPA_PLATFORM="xcb"
export QT_QPA_PLATFORMTHEME="qt6ct"
# export QT_STYLE_OVERRIDE="kvantum"

export FZF_DEFAULT_OPTS='--layout=reverse --cycle --exit-0'

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1

export LIBVIRT_DEFAULT_URI="qemu:///system"

export CHROME_EXECUTABLE=google-chrome-stable

export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_AVD_HOME="$ANDROID_USER_HOME/avd"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk-bundle"
export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=20
export NDK_HOME=$ANDROID_NDK_HOME
export OPAMROOT="$XDG_DATA_HOME/opam"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export NVM_DIR="$XDG_DATA_HOME/nvm"
# export GEM_HOME="$(gem env user_gemhome)"
export GEM_HOME="$XDG_DATA_HOME/gem"
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export GHCUP_USE_XDG_DIRS=true
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export YARN_GLOBAL_FOLDER="$XDG_DATA_HOME/yarn"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export BUN_INSTALL="$XDG_DATA_HOME/bun"
export DENO_DIR="$XDG_CACHE_HOME/deno"
export DENO_INSTALL_ROOT="$XDG_DATA_HOME/deno"
export ABBR_USER_ABBREVIATIONS_FILE="$XDG_CONFIG_HOME/zsh-abbr/user-abbreviations"
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export QSYS_ROOTDIR="$XDG_CACHE_HOME/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"
export ATAC_KEY_BINDINGS="$XDG_CONFIG_HOME/atac/bindings.toml"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PULSE_COOKIE="$XDG_CONFIG_HOME/pulse/cookie"
export AZURE_CONFIG_DIR="$XDG_DATA_HOME/azure"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export W3M_DIR="$XDG_DATA_HOME/w3m"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"
export KERAS_HOME="$XDG_STATE_HOME/keras"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export STACK_XDG=1
export PUB_CACHE="$XDG_DATA_HOME/pub-cache"
export OLLAMA_HOME="$XDG_DATA_HOME/ollama"
export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
export RUFF_CACHE_DIR="$XDG_CACHE_HOME/ruff"
export AICHAT_CONFIG_DIR="$XDG_CONFIG_HOME/aichat"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

add_to_path() { export PATH="$1:$PATH"; }

add_to_path "$HOME/.local/bin/JetBrains/Toolbox/scripts"
add_to_path "$HOME/.lmstudio/bin"
add_to_path "$HOME/.opencode/bin"
add_to_path "/home/linuxbrew/.linuxbrew/bin"
add_to_path "$JAVA_HOME/bin"
add_to_path "$DOTNET_CLI_HOME/tools"
add_to_path "$CARGO_HOME/bin"
add_to_path "$GOPATH/bin"
command -v ruby &>/dev/null && add_to_path "$GEM_HOME/ruby/$(ruby -e 'puts RbConfig::CONFIG["ruby_version"]' 2>/dev/null)/bin"
add_to_path "$XDG_DATA_HOME/npm/bin"
add_to_path "$YARN_GLOBAL_FOLDER/bin"
add_to_path "$PNPM_HOME"
add_to_path "$BUN_INSTALL/bin"
add_to_path "$DENO_INSTALL_ROOT/bin"
add_to_path "$XDG_DATA_HOME/nvim/mason/bin"
add_to_path "$XDG_DATA_HOME/sessions"
add_to_path "$HOME/.local/bin/scripts"
add_to_path "$HOME/.local/bin"
