local awful = require('awful')

require('conf.error')
require('conf.keys')
require('conf.rules')

awful.spawn.with_shell('autostart')

-- Default apps
File_manager = "thunar"
Graphical_editor = os.getenv("VISUAL")
Shell = os.getenv("SHELL")
Terminal_emulator = os.getenv("TERM")
-- Terminal_editor = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("EDITOR")
Terminal_editor = "editor"
Terminal_file_manager = Terminal_emulator .. " -e " .. os.getenv("FILEMANAGER")
Terminal_multiplexed = Terminal_emulator .. " -e fuzmux"
Web_browser = "qutebrowser"

-- require('conf.defaults')
-- require('conf.autostart')
