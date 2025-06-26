local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

local brightness = wibox.widget({
  {
    widget = brightness_widget({
      -- type = 'icon_and_text',
      type = "arc",
      program = "brightnessctl",
      step = 1,
    }),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

return brightness
