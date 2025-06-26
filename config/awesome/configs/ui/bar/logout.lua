local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")

local logout = wibox.widget({
  {
    widget = logout_popup.widget({
      onlock = function()
        awful.spawn.with_shell("lock")
      end,
    }),
  },
  margins = { left = dpi(3), right = dpi(3) },
  widget = wibox.container.margin,
})

return logout
