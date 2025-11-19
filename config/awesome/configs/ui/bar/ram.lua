local beautiful = require("beautiful")
local wibox = require("wibox")

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

local mem = wibox.widget({
  widget = ram_widget(),
  visible = false,
})

local mem_button = wibox.widget.imagebox(beautiful.mem_icon)

mem_button:connect_signal("button::press", function()
  mem.visible = not mem.visible
end)

return { mem = mem, mem_button = mem_button }
