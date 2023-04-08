local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

---@diagnostic disable-next-line: undefined-global
local screen, client, double_click_timer = screen, client, double_click_timer

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- Create exit button
  local exit_button = wibox.widget {
    forced_width = dpi(15),
    forced_height = dpi(15),
    bg = (client.focus and c == client.focus) and
        beautiful.red or beautiful.taglist_fg_empty,
    shape = function(cr, w, h) gears.shape.circle(cr, w, h) end,
    widget = wibox.container.background,
  }

  -- Add behavior to exit button
  exit_button:connect_signal("button::release", function() c:kill() end)

  -- Create maximize button
  local max_button = wibox.widget {
    forced_height = dpi(15),
    forced_width = dpi(15),
    bg = (client.focus and c == client.focus) and
        beautiful.green or beautiful.taglist_fg_empty,
    shape = function(cr, w, h) gears.shape.circle(cr, w, h) end,
    widget = wibox.container.background,
  }

  -- Add behavior to maximize button
  max_button:connect_signal("button::release", function()
    c.maximized = not c.maximized
    c:raise()
  end)

  -- Create minimize button
  local min_button = wibox.widget {
    forced_height = dpi(15),
    forced_width = dpi(15),
    bg = (client.focus and c == client.focus) and
        beautiful.blue or beautiful.taglist_fg_empty,
    shape = function(cr, w, h) gears.shape.circle(cr, w, h) end,
    widget = wibox.container.background,
  }

  -- Add behavior to minimize button
  min_button:connect_signal(
    "button::release",
    function()
      c.minimized = true
    end
  )

  -- Create floating button
  local floating_button = wibox.widget {
    forced_height = dpi(15),
    forced_width = dpi(15),
    bg = (client.focus and c == client.focus) and
        beautiful.magenta or beautiful.taglist_fg_empty,
    shape = function(cr, w, h) gears.shape.circle(cr, w, h) end,
    widget = wibox.container.background,
  }

  -- Add behavior to floating button
  floating_button:connect_signal("button::release", function()
    c.floating = not c.floating
    c:raise()
  end)

  -- Update colors of the buttons when client is focused
  local function updt_color()
    if client.focus == c then
      exit_button.bg = beautiful.red
      max_button.bg = beautiful.green
      min_button.bg = beautiful.blue
      floating_button.bg = beautiful.magenta
    else
      exit_button.bg = beautiful.taglist_fg_empty
      max_button.bg = beautiful.taglist_fg_empty
      min_button.bg = beautiful.taglist_fg_empty
      floating_button.bg = beautiful.taglist_fg_empty
    end
  end

  c:connect_signal("focus", updt_color)
  c:connect_signal("unfocus", updt_color)

  -- Adding double click functionality to titlebar
  local double_click_event_handler = function(double_click_event)
    if double_click_timer then
      double_click_timer:stop()
      double_click_timer = nil
      double_click_event()
      return
    end
    double_click_timer = gears.timer.start_new(0.20, function()
      double_click_timer = nil
      return false
    end)
  end

  -- Adding client control to the titlebar
  local control = gears.table.join(
    awful.button({}, 1, function()
      double_click_event_handler(function()
        if c.floating then
          c.floating = false
          return
        end
        c.maximized = not c.maximized
        c:raise()
      end)
      c:activate({ context = "titlebar", action = "mouse_move" })
    end),
    awful.button(
      {}, 3,
      function()
        c:activate({ context = "titlebar", action = "mouse_resize" })
      end
    )
  )

  -- Set the titlebar
  awful.titlebar(
    c,
    {
      position = 'top',
      bg       = beautiful.bg_transparent
    }
  ):setup {
    {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
        floating_button,
      },
      {
        align = "center",
        buttons = control,
        widget = awful.titlebar.widget.titlewidget(c),
      },
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
        min_button,
        max_button,
        exit_button,
      },
    },
    margins = { top = 5, bottom = 5, left = 10, right = 10 },
    widget = wibox.container.margin,
  }
end)
