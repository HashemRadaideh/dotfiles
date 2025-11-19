local beautiful = require("beautiful")
local wibox = require("wibox")

local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")

local cpu = wibox.widget({
  widget = cpu_widget({
    width = 70,
    step_width = 2,
    step_spacing = 0,
    color = "#434c5e",
  }),
  visible = false,
})

local cpu_button = wibox.widget.imagebox(beautiful.cpu_icon)

cpu_button:connect_signal("button::press", function()
  cpu.visible = not cpu.visible
end)

return { cpu = cpu, cpu_button = cpu_button }
