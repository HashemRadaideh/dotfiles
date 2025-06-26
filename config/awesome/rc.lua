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

Theme = "configs/theme.lua"
Wallpapers_path = os.getenv("HOME") .. "/Pictures/Wallpapers"

Randomize = false

Autohide = false
Gaps = true
Sloppy = false
Titles = false

Idle = os.execute([[ps -o state= -p $(pgrep xidlehook) | grep -q 'T']])

Terminal_emulator = "kitty"
Shell = os.getenv("SHELL")
Bluetooth_manager = "blueberry" -- "cinnamon-settings blueberry" -- "blueman-manager"
File_manager = "thunar"
Network_manager = "cinnamon-settings network" or Terminal_emulator .. " -e " .. Shell .. " -c nmtui"
Audio_manager = "pavucontrol"
Graphical_editor = os.getenv("VISUAL")
Terminal_editor = Terminal_emulator .. " -e " .. Shell .. " -c " .. (os.getenv("EDITOR") or "nvim")
Terminal_file_manager = Terminal_emulator .. " -e " .. Shell .. " -c yazi"
Terminal_multiplexed = Terminal_emulator .. " -e " .. Shell .. " -c fzt"
Web_browser = "floorp"

require("configs")
