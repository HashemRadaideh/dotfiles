local gears = require("gears")
local rnotification = require("ruled.notification")
local xresources = require("beautiful.xresources")

local theme_assets = require("beautiful.theme_assets")
local dpi = xresources.apply_dpi

local theme = {}

-- Path to themes folder
theme.icons_dir = gears.filesystem.get_configuration_dir() .. "configs/icons/"
theme.default_dir = gears.filesystem.get_themes_dir()

local function getHostname()
  local f = io.popen("hostnamectl | grep 'hostname' | awk '{print $3}'")
  local hostname = "Arch-Linux"
  if f then
    hostname = f:read("*a") or ""
    f:close()
    hostname = string.gsub(hostname, "\n$", "")
  end
  return hostname
end

-- Side panel profile
theme.pfp                 = theme.icons_dir .. "pfp.png"
theme.user                = os.getenv("USER")
theme.hostname            = getHostname()

-- Font
-- theme.font = "CaskaydiaCove NF 11"
-- theme.font = "JetBrainsMono NF 11"
theme.font                = "FiraCode NF 11"
-- theme.font = "SauceCodePro NF 11"
-- theme.font = "DejaVuSansMono NF 11"

-- Colors

theme.black               = "#282c34"
theme.red                 = "#e06c75"
theme.green               = "#98c379"
theme.yellow              = "#e5c07b"
theme.blue                = "#61afef"
theme.magenta             = "#c678dd"
theme.cyan                = "#56b6c2"
theme.white               = "#abb2bf"

-- General/default Settings
theme.bg_normal           = "#1e2127"
theme.bg_transparent      = theme.bg_normal .. "bf"
theme.bg_focus            = "#333333"
theme.bg_urgent           = theme.red
theme.bg_minimize         = "#444444"
theme.bg_systray          = theme.bg_normal

theme.fg_normal           = theme.white
theme.fg_focus            = theme.white
theme.fg_urgent           = theme.white
theme.fg_minimize         = theme.white

theme.border_normal       = "#000000"
theme.border_focus        = "#456789"
theme.border_marked       = "#91231c"

-- Bar
theme.bar                 = "#000000"
theme.bar_alt             = "#222222"
theme.bg_systray          = "#121212"

theme.taglist_fg_focus    = "#6A9FB8"
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty    = "#404B66"
theme.taglist_bg_focus    = "#6A9FB8"

theme.tasklist_fg_focus   = theme.fg_normal

theme.titlebar_bg_normal  = theme.bar
theme.titlebar_bg_focus   = theme.bar

-- Main menu
theme.menu_icon           = theme.icons_dir .. "menu.png"

theme.menu_font           = theme.font
theme.menu_height         = dpi(10)
theme.menu_width          = dpi(100)
theme.menu_fg_focus       = theme.fg_normal
theme.menu_fg_normal      = theme.fg_focus
theme.menu_bg_focus       = theme.bg_focus
theme.menu_bg_normal      = theme.bg_normal

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
  rnotification.append_rule {
    rule       = { urgency = 'critical' },
    properties = { bg = '#ff0000', fg = '#ffffff' }
  }
end)

theme.layout_fairh = theme.default_dir .. "default/layouts/fairhw.png"
theme.layout_fairv = theme.default_dir .. "default/layouts/fairvw.png"
theme.layout_floating = theme.default_dir .. "default/layouts/floatingw.png"
theme.layout_magnifier = theme.default_dir .. "default/layouts/magnifierw.png"
theme.layout_max = theme.default_dir .. "default/layouts/maxw.png"
theme.layout_fullscreen = theme.default_dir .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = theme.default_dir .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = theme.default_dir .. "default/layouts/tileleftw.png"
theme.layout_tile = theme.default_dir .. "default/layouts/tilew.png"
theme.layout_tiletop = theme.default_dir .. "default/layouts/tiletopw.png"
theme.layout_spiral = theme.default_dir .. "default/layouts/spiralw.png"
theme.layout_dwindle = theme.default_dir .. "default/layouts/dwindlew.png"
theme.layout_cornernw = theme.default_dir .. "default/layouts/cornernww.png"
theme.layout_cornerne = theme.default_dir .. "default/layouts/cornernew.png"
theme.layout_cornersw = theme.default_dir .. "default/layouts/cornersww.png"
theme.layout_cornerse = theme.default_dir .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.transparent_bg = theme.icons_dir .. "bg.png"

-- Mode icon
theme.mode_icon = theme.icons_dir .. "mode.png"
theme.mode_icon_active = theme.icons_dir .. "mode2.png"

-- Seprator icon
theme.arrow_left = theme.icons_dir .. "arrow_left.png"
theme.arrow_right = theme.icons_dir .. "arrow_right.png"

-- icons
theme.cpu_icon = theme.icons_dir .. "cpu.png"
theme.mem_icon = theme.icons_dir .. "memory.png"
theme.net_icon = theme.icons_dir .. "network.png"
theme.clock_icon = theme.icons_dir .. "clock.png"

return theme
