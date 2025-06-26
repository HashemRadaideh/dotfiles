local beautiful = require("beautiful")
local wibox = require("wibox")

local menu = wibox.widget.imagebox(beautiful.menu_icon)

menu:connect_signal("button::press", function()
  local function clamp(val, min, max)
    if val < min then
      return min
    end
    if val > max then
      return max
    end
    return val
  end

  ---@diagnostic disable-next-line: undefined-global, unused-local
  local s, mouse_coords = mouse.screen, mouse.coords()

  -- local target_x = s.geometry.x + (s.geometry.width - Main_menu.width) / 2
  local target_x = mouse_coords.x - (Main_menu.width / 2)
  local x = clamp(target_x, s.geometry.x, s.geometry.x + s.geometry.width - Main_menu.width)

  -- local target_y = s.geometry.y + s.bar.height + beautiful.useless_gap_size
  local target_y = mouse_coords.y
  local y =
    clamp(target_y, s.geometry.y + s.bar.height, s.geometry.y + s.geometry.height - Main_menu.height - s.bar.height)

  Main_menu:toggle({ coords = { x = x, y = y } })
end)

return menu
