local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

---@diagnostic disable-next-line: unused-local
local menu = require("configs.ui.bar.menu")
local layoutbox = require("configs.ui.bar.layoutbox")
local tags_list = require("configs.ui.bar.tagslist")
local mode_toggle = require("configs.ui.bar.modetoggle")
local tasks = require("configs.ui.bar.tasks")

local shape = require("configs.ui.bar.shape")
local clock = require("configs.ui.bar.clock")

local systray = require("configs.ui.bar.systray")
---@diagnostic disable-next-line: unused-local
local net = require("configs.ui.bar.net")
---@diagnostic disable-next-line: unused-local
local cpu = require("configs.ui.bar.cpu")
---@diagnostic disable-next-line: unused-local
local mem = require("configs.ui.bar.ram")
local bluetooth = require("configs.ui.bar.bluetooth")
local network = require("configs.ui.bar.network")
local volume_widget = require("awesome-wm-widgets.pactl-widget.volume")
local brightness = require("configs.ui.bar.brightness")
local battery = require("configs.ui.bar.battery")
local idle_inhibitor = require("configs.ui.bar.idleinhibitor")
local logout = require("configs.ui.bar.logout")

screen.connect_signal("request::desktop_decoration", function(s)
  s.bar = awful.wibar({
    hide = gears.timer({ timeout = 2.5 }),
    hover = false,
    visible = true,
    screen = s,
    type = "dock",
    ontop = false,
    stretch = false,
    bg = beautiful.bg_transparent,
    height = dpi(32),
    width = s.geometry.width,
    position = "top",
    align = "center",
    widget = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
        layout = wibox.layout.fixed.horizontal,
        exapnd = "none",
        menu,
        layoutbox,
        mode_toggle,
        tags_list(s),
        tasks.tasks_button,
        tasks.tasks_list[s],
      },
      {
        layout = wibox.layout.fixed.horizontal,
        expand = "none",
        shape(beautiful.arrow_left),
        clock,
        shape(beautiful.arrow_right),
      },
      {
        layout = wibox.layout.fixed.horizontal,
        systray.systray,
        systray.systray_button,
        -- net.net,
        -- net.net_button,
        -- mem.mem,
        -- mem.mem_button,
        -- cpu.cpu,
        -- cpu.cpu_button,
        bluetooth,
        network(),
        volume_widget({
          widget_type = "arc", -- icon_and_text
          step = 1,
        }),
        brightness,
        battery(),
        idle_inhibitor,
        logout,
      },
    },
  })

  if Autohide then
    s.bar.hide:start()
  end

  s.bar:connect_signal("mouse::enter", function()
    s.bar.visible = true
    s.bar.hover = true
    s.bar.hide:stop()
  end)

  s.bar:connect_signal("mouse::leave", function()
    s.bar.hover = false

    s.bar.hide:connect_signal("timeout", function()
      if not s.bar.hover then
        s.bar.visible = not Autohide
      end
      s.bar.hide:stop()
    end)

    s.bar.hide:start()
  end)

  s.bar.hide:connect_signal("timeout", function()
    if not s.bar.hover then
      s.bar.visible = not Autohide
    end
    s.bar.hide:stop()
  end)
end)
