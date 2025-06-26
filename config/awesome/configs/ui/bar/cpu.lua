local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")

local cpu = wibox.widget({
  widget = wibox.container.margin,
  visible = false,
  left = 10,
  top = 2,
  bottom = 2,
  right = 10,
  cpu_widget({
    width = 70,
    step_width = 2,
    step_spacing = 0,
    color = "#434c5e",
  }),
})

local cpu_button = wibox.widget({
  {
    widget = wibox.widget.imagebox(beautiful.cpu_icon),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

cpu_button:connect_signal("button::press", function()
  cpu.visible = not cpu.visible
end)

return { cpu = cpu, cpu_button = cpu_button }
