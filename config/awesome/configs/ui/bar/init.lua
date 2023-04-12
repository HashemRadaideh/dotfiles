local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

---@diagnostic disable-next-line: undefined-global
local screen, dpi = screen, beautiful.xresources.apply_dpi

-- Widgets
require("configs.ui.bar.widgets")

local logout_popup = require(
  "awesome-wm-widgets.logout-popup-widget.logout-popup"
)

local volume_widget = require(
  'awesome-wm-widgets.volume-widget.volume'
)

local batteryarc_widget = require(
  "awesome-wm-widgets.batteryarc-widget.batteryarc"
)

-- Set up the bar
screen.connect_signal("request::desktop_decoration", function(s)
  s.mypromptbox = awful.widget.prompt()

  Create_tags(s)

  Task = Tasks(s)

  s.Bar = awful.wibar {
    visible      = true,
    screen       = s,
    bg           = beautiful.bg_transparent,
    height       = s.geometry.height / dpi(40),
    -- height       = dpi(35),
    width        = s.geometry.width - dpi(0),
    position     = "top",
    stretch      = false,
    type         = "dock",
    border_width = 0,
    border_color = beautiful.black,
    align        = "center",
    margins      = {
      top = 0,
      left = 0,
      right = 0,
      bottom = 0,
    },
    widget       = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
        layout = wibox.layout.fixed.horizontal,
        Menu,
        -- Shape(beautiful.arrow_right),
        TaskButton,
        Task,
      },
      {
        layout = wibox.layout.fixed.horizontal,
        Shape(beautiful.arrow_left),
        Layoutbox,
        Tags(s),
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
        -- MEM,
        -- MEMButton,
        -- CPU,
        -- CPUButton,
        batteryarc_widget({
          show_current_level = true,
          arc_thickness = 1,
        }),
        volume_widget { widget_type = 'arc' },
        logout_popup.widget {
          onlock = function() awful.spawn.with_shell("lock") end,
          onsuspend = function()
            awful.spawn.with_shell("lock && systemctl suspend")
          end
        },
      },
    }
  }

  --Auto hide bar
  ---@diagnostic disable-next-line: undefined-global
  local hide = timer({ timeout = 10 })

  hide:connect_signal("timeout", function()
    s.Bar.visible = false
    hide:stop()
  end)

  hide:start()
end)
