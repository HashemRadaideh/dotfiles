local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local capi = { keygrabber = keygrabber }

local clock = wibox.widget({ widget = wibox.widget.textbox })

local function ordinal(n)
  local suffix = "th"
  local rem100 = n % 100
  local rem10 = n % 10
  if rem100 < 11 or rem100 > 13 then
    if rem10 == 1 then
      suffix = "st"
    elseif rem10 == 2 then
      suffix = "nd"
    elseif rem10 == 3 then
      suffix = "rd"
    end
  end
  return tostring(n) .. suffix
end

gears.timer({
  timeout = 1,
  autostart = true,
  call_now = true,
  callback = function()
    clock.markup = "<span foreground='#ffffff'>"
      .. os.date(" %A, ")
      .. ordinal(tonumber(os.date("%d")))
      .. os.date(" of %B %Y, %I:%M:%S %p ")
      .. "</span>"
  end,
})

-- Calendar Popup State
local current_month = os.date("*t").month
local current_year = os.date("*t").year

-- Calendar content widget
local cal_text = wibox.widget({
  widget = wibox.widget.textbox,
  font = "monospace 10",
  align = "center",
})

-- Function to update the calendar
local function update_calendar()
  local f = io.popen("cal " .. current_month .. " " .. current_year)
  if not f then
    cal_text.text = "error running cal"
    return
  end

  local lines = {}
  for line in f:lines() do
    table.insert(lines, line)
  end
  f:close()

  local today = os.date("*t")
  for i = #lines, 1, -1 do
    if current_month == today.month and current_year == today.year then
      lines[i] = lines[i]:gsub("(%d%d?)", function(day)
        return tonumber(day) == today.day
            and string.format("<span background='#5e81ac' foreground='#ffffff' weight='bold'>%s</span>", day)
          or day
      end)
    end

    if lines[i]:match("^%s*$") then
      table.remove(lines, i)
    end
  end

  cal_text.markup = table.concat(lines, "\n")
end

-- Navigation buttons
local function create_nav_button(symbol, delta)
  local btn = wibox.widget({
    text = symbol,
    widget = wibox.widget.textbox,
    align = "center",
  })

  btn:connect_signal("button::press", function()
    current_month = current_month + delta
    if current_month < 1 then
      current_month, current_year = 12, current_year - 1
    elseif current_month > 12 then
      current_month, current_year = 1, current_year + 1
    end
    update_calendar()
  end)

  return btn
end

local prev_btn = create_nav_button("←", -1)
local next_btn = create_nav_button("→", 1)

-- Full popup calendar widget
local calendar = awful.popup({
  widget = {
    {
      {
        prev_btn,
        {
          widget = wibox.widget.textbox,
          text = "   Calendar   ",
          align = "center",
        },
        next_btn,
        layout = wibox.layout.align.horizontal,
      },
      cal_text,
      layout = wibox.layout.fixed.vertical,
      spacing = 5,
      margins = 10,
    },
    widget = wibox.container.margin,
    margins = 10,
  },
  border_color = "#ffffff",
  border_width = 1,
  -- shape = gears.shape.rounded_rect,
  ontop = true,
  visible = false,
  x = 0,
  y = 0,
})

-- Toggle popup on click
clock:connect_signal("button::press", function()
  if calendar.visible then
    calendar.visible = false
    capi.keygrabber.stop()
  else
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

    local target_x = s.geometry.x + (s.geometry.width - calendar.width) / 2
    -- local target_x = mouse_coords.x - (calendar_popup.width / 2)
    calendar.x = clamp(
      target_x,
      s.geometry.x + beautiful.useless_gap_size,
      s.geometry.x + s.geometry.width - calendar.width - beautiful.useless_gap_size
    )

    local target_y = s.geometry.y + s.bar.height + beautiful.useless_gap_size
    -- local target_y = mouse_coords.y + s.bar.height + beautiful.useless_gap_size
    calendar.y = clamp(
      target_y,
      s.geometry.y + s.bar.height + beautiful.useless_gap_size,
      s.geometry.y + s.geometry.height - calendar.height - s.bar.height - beautiful.useless_gap_size
    )

    update_calendar()

    calendar.visible = true

    capi.keygrabber.run(function(_, _, event)
      if event == "release" then
        return
      end

      capi.keygrabber.stop()
      calendar.visible = false
    end)
  end
end)

client.connect_signal("button::press", function()
  if calendar.visible then
    calendar.visible = false
    capi.keygrabber.stop()
  end
end)

return clock
