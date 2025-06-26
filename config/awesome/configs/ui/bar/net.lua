local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")

local net = wibox.widget({
  widget = wibox.container.margin,
  visible = false,
  left = 10,
  top = 2,
  bottom = 2,
  right = 10,
  net_speed_widget(),
})

local net_button = wibox.widget({
  {
    widget = wibox.widget.imagebox(beautiful.net_icon),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

net_button:connect_signal("button::press", function()
  net.visible = not net.visible
end)

return { net = net, net_button = net_button }
