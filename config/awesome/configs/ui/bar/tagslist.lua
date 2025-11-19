local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local function tags_list(s)
  return awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({ Super }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ Super }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
      end)
    ),
    widget_template = {
      {
        {
          id = "text_role",
          forced_width = dpi(32),
          align = "center",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      widget = wibox.container.background,
      create_callback = function(self)
        local old_cursor, old_wibox

        self.bg = "#ffffff00"

        self:connect_signal("mouse::enter", function()
          ---@diagnostic disable-next-line: undefined-global
          local w = mouse.current_wibox
          if w then
            old_cursor, old_wibox = w.cursor, w
            w.cursor = "hand1"
          end
          self.bg = "#ffffff11"
        end)

        self:connect_signal("mouse::leave", function()
          if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
          end
          self.bg = "#ffffff00"
        end)
      end,
    },
  })
end

return tags_list
