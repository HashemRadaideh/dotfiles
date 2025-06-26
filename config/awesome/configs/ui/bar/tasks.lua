local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local function tasks(s)
  return wibox.widget({
    visible = false,
    widget = awful.widget.tasklist({
      visible = false,
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      style = {
        shape_border_width = 1,
        shape_border_color = "#777777",
        shape = gears.shape.rounded_bar,
      },
      layout = {
        spacing = 10,
        spacing_widget = {
          {
            forced_width = 5,
            shape = gears.shape.circle,
            widget = wibox.widget.separator,
          },
          valign = "center",
          halign = "center",
          widget = wibox.container.place,
        },
        layout = wibox.layout.flex.horizontal,
      },
      -- Notice that there is *NO* wibox.wibox prefix, it is a template,
      -- not a widget instance.
      widget_template = {
        {
          {
            {
              {
                id = "icon_role",
                widget = wibox.widget.imagebox,
              },
              margins = 2,
              widget = wibox.container.margin,
            },
            -- {
            --   id     = 'text_role',
            --   widget = wibox.widget.textbox,
            -- },
            layout = wibox.layout.fixed.horizontal,
          },
          left = 10,
          right = 10,
          widget = wibox.container.margin,
        },
        id = "background_role",
        widget = wibox.container.background,
      },
      buttons = {
        awful.button({}, 1, function(c)
          c:activate({
            context = "tasklist",
            action = "toggle_minimization",
          })
        end),
        awful.button({}, 3, function()
          awful.menu.client_list({
            theme = {
              width = 200,
              height = 20,
            },
          })
        end),
        awful.button({}, 4, function()
          awful.client.focus.byidx(-1)
        end),
        awful.button({}, 5, function()
          awful.client.focus.byidx(1)
        end),
      },
    }),
  })
end

local tasks_list = {}

for s in screen do
  tasks_list[s] = tasks(s)
end

local tasks_button = wibox.widget.imagebox(beautiful.arrow_right)

tasks_button:connect_signal("button::press", function(self)
  for s in screen do
    tasks_list[s].visible = not tasks_list[s].visible

    self.image = tasks_list[s].visible and beautiful.arrow_left or beautiful.arrow_right
  end
end)

return { tasks_list = tasks_list, tasks_button = tasks_button }
