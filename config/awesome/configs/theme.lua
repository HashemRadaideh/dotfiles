local gears = require("gears")
local rnotification = require("ruled.notification")
local xresources = require("beautiful.xresources")

local theme_assets = require("beautiful.theme_assets")
local dpi = xresources.apply_dpi

local theme = {}

-- Path to themes folder
theme.assets_dir = gears.filesystem.get_configuration_dir() .. "assets/"
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
theme.pfp = theme.assets_dir .. "pfp.png"
theme.user = os.getenv("USER")
theme.hostname = getHostname()

-- Font
theme.font_name = "CaskaydiaCove Nerd Font"
theme.font = theme.font_name .. "12"
-- theme.font                = "JetBrainsMono Nerd Font 11"
-- theme.font                = "FiraCode Nerd Font 11"
-- theme.font                = "SauceCodePro Nerd Font 11"
-- theme.font                = "DejaVuSansMono Nerd Font 11"

-- Colors
theme.background = "#303446"
theme.bright_background = "#A5ADCE"

theme.foreground = "#C6D0F5"
theme.dim_foreground = "#F2D5CF"
theme.bright_foreground = "#BABBF1"

theme.black = "#51576D"
theme.red = "#E78284"
theme.green = "#A6D189"
theme.yellow = "#E5C890"
theme.blue = "#8CAAEE"
theme.magenta = "#F4B8E4"
theme.cyan = "#81C8BE"
theme.white = "#B5BFE2"

-- theme.background          = '#1e2127'
-- theme.foreground          = '#abb2bf'
-- theme.dim_foreground      = '#9a9a9a'
-- theme.bright_foreground   = '#e6efff'

-- theme.black               = '#1e2127'
-- theme.red                 = '#e06c75'
-- theme.green               = '#98c379'
-- theme.yellow              = '#d19a66'
-- theme.blue                = '#61afef'
-- theme.magenta             = '#c678dd'
-- theme.cyan                = '#56b6c2'
-- theme.white               = '#abb2bf'

-- theme.black               = '#5c6370'
-- theme.red                 = '#e06c75'
-- theme.green               = '#98c379'
-- theme.yellow              = '#d19a66'
-- theme.blue                = '#61afef'
-- theme.magenta             = '#c678dd'
-- theme.cyan                = '#56b6c2'
-- theme.white               = '#ffffff'

-- theme.black               = "#282c34"
-- theme.red                 = "#e06c75"
-- theme.green               = "#98c379"
-- theme.yellow              = "#e5c07b"
-- theme.blue                = "#61afef"
-- theme.magenta             = "#c678dd"
-- theme.cyan                = "#56b6c2"
-- theme.white               = "#abb2bf"

-- General/default Settings
theme.bg_normal = theme.background
theme.bg_transparent = theme.bg_normal .. "bf"
theme.bg_focus = theme.black
theme.bg_urgent = theme.red
theme.bg_minimize = theme.white
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.foreground
theme.fg_focus = theme.bright_foreground
theme.fg_urgent = theme.red
theme.fg_minimize = theme.dim_foreground

theme.border_normal = theme.black
theme.border_focus = theme.blue
theme.border_marked = theme.red
theme.border_width = dpi(2)

theme.useless_gap = 0
theme.useless_gap_size = dpi(8)
theme.gap_single_client = true

theme.master_count = 1
theme.column_count = 1

theme.master_fill_policy = "master_width_factor"
theme.master_fill_policy = "expand"
theme.master_width_factor = 0.5

-- Bar
theme.bar = theme.background
theme.bar_alt = theme.bright_background
theme.bg_systray = theme.background

theme.taglist_fg_focus = theme.blue
theme.taglist_bg_focus = theme.blue
theme.taglist_fg_occupied = theme.bright_background
theme.taglist_fg_empty = theme.background

theme.tasklist_fg_focus = theme.fg_normal

theme.titlebar_bg_normal = theme.bar
theme.titlebar_bg_focus = theme.bar

-- Main menu
theme.menu_icon = theme.assets_dir .. "menu.png"

theme.menu_font = theme.font
theme.menu_height = dpi(10)
theme.menu_width = dpi(100)
theme.menu_fg_focus = theme.fg_normal
theme.menu_fg_normal = theme.fg_focus
theme.menu_bg_focus = theme.bg_focus
theme.menu_bg_normal = theme.bg_normal

-- Set different colors for urgent notifications.
rnotification.connect_signal("request=rules", function()
  rnotification.append_rule({
    rule = { urgency = "critical" },
    properties = { bg = theme.red, fg = theme.foreground },
  })
end)

theme.notification_shape = function(cr, w, h)
  gears.shape.rounded_rect(cr, w, h, theme.border_radius)
end
theme.notification_opacity = 75
theme.notification_font = theme.font
theme.notification_padding = dpi(5)
theme.notification_spacing = dpi(5)
theme.notification_margin = dpi(5)
theme.notification_border_width = dpi(5)
theme.notification_position = "top_right"

theme.notification_low_bg = theme.background
theme.notification_low_fg = theme.foreground
theme.notification_low_border_color = theme.bright_background

theme.notification_bg = theme.background
theme.notification_fg = theme.foreground
theme.notification_border_color = theme.bright_background

theme.notification_crit_bg = theme.background
theme.notification_crit_fg = theme.foreground
theme.notification_crit_border_color = theme.red

-- theme.notification_width = ""
-- theme.notification_height = ""
-- theme.notification_max_width = ""
-- theme.notification_max_height = ""
-- theme.notification_icon_size = ""

theme.tooltip_border_color = theme.bright_background
theme.tooltip_bg = theme.background
theme.tooltip_fg = theme.foreground
theme.tooltip_font = theme.font
theme.tooltip_border_width = dpi(1)
theme.tooltip_opacity = 75
theme.tooltip_shape = function(cr, w, h)
  gears.shape.rounded_rect(cr, w, h, theme.border_radius)
end
-- theme.tooltip_align = ""

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
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Mode icon
theme.mode_zen = theme.assets_dir .. "modes/zen.png"
theme.mode_casual = theme.assets_dir .. "modes/casual.png"
theme.mode_custom = theme.assets_dir .. "modes/custom.png"

-- Seprator icon
theme.arrow_left = theme.assets_dir .. "arrow_left.png"
theme.arrow_right = theme.assets_dir .. "arrow_right.png"

-- icons
theme.cpu_icon = theme.assets_dir .. "cpu.png"
theme.mem_icon = theme.assets_dir .. "memory.png"
theme.net_icon = theme.assets_dir .. "network.png"
theme.clock_icon = theme.assets_dir .. "clock.png"

theme.default_wallpaper = theme.assets_dir .. "archlinux.png"

return theme
