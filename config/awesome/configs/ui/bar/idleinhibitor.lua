local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local idle_inhibitor = wibox.widget({
  margins = { left = dpi(3), right = dpi(3) },
  halign = "center",
  valign = "center",
  text = Idle and " " or " ",
  widget = wibox.widget.textbox,
})

local tooltip = awful.tooltip({
  objects = { idle_inhibitor },
  text = Idle and "Currently keeping the system active. Click to allow sleep."
    or "Currently allowing the system to sleep. Click to keep active.",
  mode = "outside", -- Optional, you can use "outside" to make it appear outside the widget
  align = "right", -- Optional, aligns the tooltip
})

idle_inhibitor:connect_signal("button::press", function(self)
  awful.spawn.with_shell("toggleidle")

  Idle = not Idle

  if Idle then
    self.text = " "
    tooltip.text = "Currently keeping the system active. Click to allow sleep."
  else
    self.text = " "
    tooltip.text = "Currently allowing the system to sleep. Click to keep active."
  end
end)

return idle_inhibitor
