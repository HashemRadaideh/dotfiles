local awful = require('awful')

awful.spawn.with_shell('autostart')

-- Default apps
File_manager = "pcmanfm"
Graphical_editor = os.getenv("VISUAL")
Shell = os.getenv("SHELL")
Terminal_emulator = os.getenv("TERMINAL")
Terminal_editor = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("EDITOR")
Terminal_file_manager = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("FILEMANAGER")
Terminal_multiplexed = Terminal_emulator .. " -e " .. Shell .. " -c " .. "fzt"
Bluetooth_manager = "blueman-manager"
Network_manager = "nm-connection-editor"
Web_browser = "qutebrowser"

require('configs.keys')
require('configs.rules')
require('configs.ui')

ZenSwitch()

require('configs.notifications')
