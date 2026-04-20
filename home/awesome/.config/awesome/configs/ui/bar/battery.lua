local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local clickable_container = require("configs.ui.bar.clickable-container")

-- local battery_widget = require(
--   "awesome-wm-widgets.battery-widget.battery"
-- )

local function battery()
  local cmd = [[
    [ "$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}' | sed 's/\%//g')" -le 100 ] && true || false
  ]]

  if os.execute(cmd) then
    return wibox.widget({
      {
        batteryarc_widget({
          show_current_level = true,
          arc_thickness = 2,
          --   display_notification = true,
          show_notification_mode = "on_click",
        }),
        margins = { left = dpi(3), right = dpi(5) },
        widget = wibox.container.margin,
      },
      widget = clickable_container,
    })
  end
end

return battery
