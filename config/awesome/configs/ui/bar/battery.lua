local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

-- local battery_widget = require(
--   "awesome-wm-widgets.battery-widget.battery"
-- )

local function battery()
  local cmd = [[
    LEVEL="$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}' | sed 's/\%//g')"

    if [ $LEVEL -le 100 ]; then
      true
    else
      false
    fi
  ]]

  if os.execute(cmd) then
    return wibox.widget({
      {
        -- widget = battery_widget({
        --   show_current_level = true,
        --   display_notification = true,
        -- }),
        widget = batteryarc_widget({
          show_current_level = true,
          arc_thickness = 2,
        }),
      },
      margins = { left = dpi(3), right = dpi(5) },
      widget = wibox.container.margin,
    })
  end
end

return battery
