local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

-- Widgets
require("configs.ui.bar.widgets")

local network = require("configs.ui.bar.network")
local bluetooth = require("configs.ui.bar.bluetooth")
local volume_widget = require("awesome-wm-widgets.pactl-widget.volume")

local net = network()
local bat = Battery()

screen.connect_signal("request::desktop_decoration", function(s)
  s.mypromptbox = awful.widget.prompt()

  Create_tags(s)

  Task = Tasks(s)

  s.Bar = awful.wibar({
    type = "dock",
    screen = s,
    visible = true,
    hide = gears.timer({ timeout = 2.5 }),
    hover = false,
    ontop = false,
    bg = beautiful.bg_transparent,
    x = 0,
    y = 0,
    height = s.geometry.height / 40,
    width = s.geometry.width,
    stretch = false,
    position = "top",
    border_width = 0,
    border_color = beautiful.black,
    align = "center",
    margins = {
      top = 0,
      left = 0,
      right = 0,
      bottom = 0,
    },
    widget = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
        layout = wibox.layout.fixed.horizontal,
        Menu,
        TaskButton,
        Task,
      },
      {
        layout = wibox.layout.fixed.horizontal,
        Shape(beautiful.arrow_left),
        Layoutbox,
        Tagslist(s),
        ModeToggle,
        Shape(beautiful.arrow_right),
      },
      {
        layout = wibox.layout.fixed.horizontal,
        Systray,
        SystrayButton,
        Clock,
        -- NET,
        -- NETButton,
        MEM,
        MEMButton,
        CPU,
        CPUButton,
        bluetooth,
        net,
        -- Volume,
        volume_widget({
          widget_type = "arc", -- icon_and_text
          -- width = s.geometry.width / 15,
          -- margins = { top = 0, bottom = 0, left = 0, right = 0 },
          -- margins = 0,
        }),
        Brightness,
        bat,
        IdleInhibitor,
        Logout,
      },
    },
  })

  if Autohide then
    s.Bar.hide:start()
  end

  s.Bar:connect_signal("mouse::enter", function()
    s.Bar.visible = true
    s.Bar.hover = true
    s.Bar.hide:stop()
  end)

  s.Bar:connect_signal("mouse::leave", function()
    s.Bar.hover = false

    s.Bar.hide:connect_signal("timeout", function()
      if not s.Bar.hover then
        s.Bar.visible = not Autohide
      end
      s.Bar.hide:stop()
    end)

    s.Bar.hide:start()
  end)

  s.Bar.hide:connect_signal("timeout", function()
    if not s.Bar.hover then
      s.Bar.visible = not Autohide
    end
    s.Bar.hide:stop()
  end)
end)
