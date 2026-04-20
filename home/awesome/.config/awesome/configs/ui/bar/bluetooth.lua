local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local clickable_container = require("configs.ui.bar.clickable-container")

local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "assets/bluetooth/"

local checker

local widget = wibox.widget({
  {
    id = "icon",
    widget = wibox.widget.imagebox,
    resize = true,
  },
  layout = wibox.layout.align.horizontal,
})

local widget_button = wibox.widget({
  {
    widget,
    margins = { left = dpi(2), top = dpi(7), bottom = dpi(7), right = dpi(2) },
    widget = wibox.container.margin,
  },
  widget = clickable_container,
})

widget_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
  awful.spawn(Bluetooth_manager)
end)))

awful.tooltip({
  objects = { widget_button },
  mode = "outside",
  align = "right",
  timer_function = function()
    if checker ~= nil then
      return "Bluetooth is on"
    else
      return "Bluetooth is off"
    end
  end,
  preferred_positions = { "right", "left", "top", "bottom" },
})

local last_bluetooth_check = os.time()
watch("bluetoothctl --monitor list", 5, function(_, stdout)
  -- Check if there  bluetooth
  checker = stdout:match("Controller") -- If 'Controller' string is detected on stdout
  local widget_icon_name
  if checker ~= nil then
    widget_icon_name = "bluetooth"
  else
    widget_icon_name = "bluetooth-off"
  end
  widget.icon:set_image(widget_icon_dir .. widget_icon_name .. ".svg")
  collectgarbage("collect")
end, widget)

return widget_button
