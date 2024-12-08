-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- autostart applications
-- require("awful").spawn.easy_async_with_shell("autostart")
-- require("awful").spawn.easy_async_with_shell("dex -as $XDG_CONFIG_HOME/autostart")
require("awful").spawn.with_shell("autostart")

-- Standard awesome library
require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

Bluetooth_manager = "cinnamon-settings blueberry"
File_manager = "thunar"
Network_manager = "cinnamon-settings network"
Power_manager = "cinnamon-settings power"
-- Audio_utility = "pavucontrol"
Graphical_editor = os.getenv("VISUAL")
Terminal_emulator = os.getenv("TERMINAL")
Shell = os.getenv("SHELL")
Terminal_editor = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("EDITOR")
Terminal_file_manager = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("FILEMANAGER")
Terminal_multiplexed = Terminal_emulator .. " -e " .. Shell .. " -c fzt"
Web_browser = "floorp"

Autohide = true
Zen = true
Sloppy = false
Titled = false
Idle = os.execute([[ps -o state= -p $(pgrep xidlehook) | grep -q 'T']])

Theme = "configs/theme.lua"

require("configs")
