local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local capi = { keygrabber = keygrabber, client = client }
local current_menu = {}

local function client_list_menu(s)
  if current_menu[s] and current_menu[s].wibox.visible then
    current_menu[s]:hide()
    capi.keygrabber.stop()
    return
  end

  local menu_items = {}
  local longest = ""

  for _, c in ipairs(client.get()) do
    if c.screen == s then -- and c:isvisible() and c.name
      if #c.name > #longest then
        longest = c.name
      end

      table.insert(menu_items, {
        c.name,
        function()
          c:jump_to()
        end,
        c.icon,
      })
    end
  end

  local menu = awful.menu({
    items = menu_items,
    theme = {
      width = dpi(28) + dpi(#longest * 10),
      height = dpi(28),
    },
  })

  menu:show()
  current_menu[s] = menu

  capi.keygrabber.stop()

  capi.keygrabber.run(function(_, _, event)
    if event == "release" then
      return
    end
    capi.keygrabber.stop()
    if current_menu[s] then
      current_menu[s]:hide()
      current_menu[s] = nil
    end
  end)

  local function hide_menu_on_click()
    if current_menu[s] and current_menu[s].wibox.visible then
      current_menu[s]:hide()
      current_menu[s] = nil
      capi.keygrabber.stop()
    end
  end

  local disconnect
  disconnect = capi.client.connect_signal("button::press", function()
    hide_menu_on_click()
    if disconnect then
      capi.client.disconnect_signal("button::press", disconnect)
    end
  end)

  return menu
end

local function tasks(s)
  return wibox.widget({
    visible = false,
    widget = awful.widget.tasklist({
      screen = s,
      filter = function(c, scr)
        return awful.widget.tasklist.filter.currenttags(c, scr) and c.screen == scr
      end,
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
        awful.button({}, 2, function(c)
          c:kill()
        end),
        awful.button({}, 3, function()
          client_list_menu(s)
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
