local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local systray = wibox.widget({
  widget = wibox.widget.systray(),
  bg = beautiful.bg_transparent,
  shape = gears.shape.rounded_rect,
  shape_clip = true,
  visible = false,
})

local systray_button = wibox.widget.imagebox(beautiful.arrow_left)

systray_button:connect_signal("button::press", function(self)
  systray.visible = not systray.visible

  self.image = systray.visible and beautiful.arrow_right or beautiful.arrow_left
end)

return { systray = systray, systray_button = systray_button }
