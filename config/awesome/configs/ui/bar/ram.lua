local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

local mem = wibox.widget({
  widget = wibox.container.margin,
  visible = false,
  left = 10,
  top = 2,
  bottom = 2,
  right = 10,
  ram_widget(),
})

local mem_button = wibox.widget({
  {
    widget = wibox.widget.imagebox(beautiful.mem_icon),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

mem_button:connect_signal("button::press", function()
  mem.visible = not mem.visible
end)

return { mem = mem, mem_button = mem_button }
