local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local layoutbox = wibox.widget({
  {
    widget = awful.widget.layoutbox,
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end),
  },
})

return layoutbox
