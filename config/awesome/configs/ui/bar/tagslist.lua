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
      id = "text_role",
      forced_width = dpi(35),
      align = "center",
      widget = wibox.widget.textbox,
      -- create_callback = function(self, c3)
      --   self:connect_signal("button::press", function()
      --     if c3.selected then
      --       self:get_children_by_id("text_role")[1].markup = "0"
      --     else
      --       self:get_children_by_id("text_role")[1].markup = "O"
      --     end
      --   end)
      --
      --   self:connect_signal('mouse::enter', function()
      --     if self.markup ~= '0' then
      --       self.backup     = self.markup
      --       self.has_backup = true
      --     end
      --     self.text = ""
      --   end)
      --
      --   self:connect_signal('mouse::leave', function()
      --     if self.has_backup then self.markup = self.backup end
      --   end)
      --
      --   if c3.selected then
      --     self:get_children_by_id("text_role")[1].markup = "0"
      --   else
      --     self:get_children_by_id("text_role")[1].markup = "O"
      --   end
      -- end,

      -- update_callback = function(self, c3, _)
      --   if c3.selected then
      --     self:get_children_by_id("text_role")[1].markup = "0"
      --   else
      --     self:get_children_by_id("text_role")[1].markup = "O"
      --   end
      -- end,
    },
  })
end

return tags_list
