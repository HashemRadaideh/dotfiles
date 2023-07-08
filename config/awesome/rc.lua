Bluetooth_manager = "blueman-manager"
File_manager = "pcmanfm"
Graphical_editor = os.getenv("VISUAL")
Network_manager = "nm-connection-editor"
Power_manager = "xfce4-power-manager"
Shell = os.getenv("SHELL")
Terminal_emulator = os.getenv("TERMINAL")
Terminal_editor = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("EDITOR")
Terminal_file_manager = Terminal_emulator .. " -e " .. Shell .. " -c " .. os.getenv("FILEMANAGER")
Terminal_multiplexed = Terminal_emulator .. " -e " .. Shell .. " -c " .. "fzt"
Web_browser = "google-chrome-stable"

Autohide = true
Zen = true
Sloppy = false
Titled = false

Theme = "configs/theme.lua"

require('configs')
