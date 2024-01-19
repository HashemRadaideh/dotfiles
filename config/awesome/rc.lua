-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

Bluetooth_manager     = "blueman-manager"
File_manager          = "pcmanfm"
Network_manager       = "nm-connection-editor"
Power_manager         = "xfce4-power-manager"
Graphical_editor      = os.getenv("VISUAL")
Terminal_emulator     = os.getenv("TERMINAL")
Shell                 = os.getenv("SHELL")
Terminal_editor       = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("EDITOR")
Terminal_file_manager = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("FILEMANAGER")
Terminal_multiplexed  = Terminal_emulator .. " -e " .. Shell .. " -c fzt"
Web_browser           = "google-chrome-stable"

Autohide              = true
Zen                   = true
Sloppy                = false
Titled                = false

Theme                 = "configs/theme.lua"

require('configs')
