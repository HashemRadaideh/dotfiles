local beautiful = require("beautiful")
local wibox = require("wibox")

local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")

local net = wibox.widget({
  widget = net_speed_widget(),
  visible = false,
})

local net_button = wibox.widget.imagebox(beautiful.net_icon)

net_button:connect_signal("button::press", function()
  net.visible = not net.visible
end)

return { net = net, net_button = net_button }
