local awful                        = require('awful')
local beautiful                    = require('beautiful')
local gears                        = require('gears')
local wibox                        = require('wibox')
local naughty                      = require('naughty')

---@diagnostic disable-next-line: undefined-global
local screen, dpi, awesome, client = screen, beautiful.xresources.apply_dpi, awesome, client

Desktop                            = {}

Desktop.Tasks                      = awful.popup {
  widget       = awful.widget.tasklist {
    screen          = screen[1],
    filter          = awful.widget.tasklist.filter.currenttags,
    style           = {
      shape = gears.shape.rounded_bar,
    },
    layout          = {
      spacing = 5,
      forced_num_rows = 2,
      layout = wibox.layout.grid.horizontal
    },
    widget_template = {
      {
        {
          id     = 'clienticon',
          widget = awful.widget.clienticon,
        },
        margins = 4,
        widget  = wibox.container.margin,
      },
      id              = 'background_role',
      forced_width    = 48,
      forced_height   = 48,
      widget          = wibox.container.background,
      create_callback = function(self, c, index, objects) --luacheck: no unused
        self:get_children_by_id('clienticon')[1].client = c
      end,
    },
    buttons         = {
      awful.button(
        {}, 1,
        function(c)
          c:activate {
            context = "tasklist",
            action = "toggle_minimization"
          }
        end
      ),
      awful.button(
        {}, 3,
        function()
          awful.menu.client_list {
            theme = {
              width = 200,
              height = 20
            }
          }
        end
      ),
      awful.button(
        {}, 4,
        function() awful.client.focus.byidx(-1) end
      ),
      awful.button(
        {}, 5,
        function() awful.client.focus.byidx(1) end
      ),
    },
  },
  border_color = '#777777',
  border_width = 2,
  ontop        = true,
  placement    = awful.placement.centered,
  shape        = gears.shape.rounded_rect,
  visible      = false
}

Desktop.Clock                      = wibox {
  visible = false,
  x       = screen.primary.geometry.width / 2 - 275,
  y       = 69,
  width   = 550,
  height  = 225,
  bg      = "#000000" .. "00",
  fg      = "#ffffff",
  shape   = gears.shape.rounded_rect,
  widget  = wibox.widget.textclock(
    (
    [[         <span font="Anurati 69"> %s </span>
            <span font="Monospace 21"> %s %s, %s </span>
                      <span font="Monospace 16"> - %s:%s %s - </span>]]
    ):format(
      os.date('%A'):upper(),
      os.date('%d'),
      os.date('%B'),
      os.date('%Y'),
      os.date('%I'),
      os.date('%M'),
      os.date('%p')
    )
  ),
}

Desktop.Side_Panel                 = wibox {
  screen = screen.primary,
  visible = false,
  width = screen.primary.geometry.height - 400,
  height = screen.primary.geometry.height - screen.primary.Bar.height,
  x = screen.primary.geometry.width - 400,
  y = screen.primary.Bar.height,
  bg = beautiful.bg_transparent,
  fg = "#ffffff",
  ontop = true,
  shape = gears.shape.rounded_rect,
  buttons = {
    awful.button(
      {}, 1,
      function()
        Desktop.Side_Panel.visible = not Desktop.Side_Panel.visible
      end,
      { description = 'Toggle Side Panel', group = 'awesome' }
    ),
    awful.button(
      {}, 3,
      function()
        Desktop.Side_Panel.visible = not Desktop.Side_Panel.visible
      end,
      { description = 'Toggle Side Panel', group = 'awesome' }
    )
  },
  widget = {
    layout = wibox.layout.align.vertical,
    {
      layout = wibox.layout.align.vertical,
      {
        widget = wibox.container.margin,
        left   = 10,
        top    = 10,
        bottom = 10,
        right  = 10,
        shape  = gears.shape.rounded_rect,
        {
          forced_width  = dpi(380),
          forced_height = dpi(380),
          image         = beautiful.pfp,
          resize        = true,
          widget        = wibox.widget.imagebox,
        }
      },
      {
        widget = wibox.container.margin,
        left   = 60,
        top    = 2,
        bottom = 2,
        right  = 10,
        {
          markup = '' ..
              '<span font="Monospace 21">' ..
              beautiful.user .. "@" .. beautiful.hostname ..
              '</span>',
          forced_width = dpi(400),
          widget = wibox.widget.textbox,
        }
      },
    },
  },
}

if Autohide then
  Desktop.Bartoggle = wibox {
    visible = true,
    ontop   = true,
    x       = 0,
    y       = 0,
    width   = screen.primary.geometry.width,
    height  = 1,
    bg      = "#000000",
  }

  Desktop.Bartoggle:connect_signal('mouse::enter', function(self)
    for s in screen do
      s.Bar.visible = true
      ---@diagnostic disable-next-line: undefined-global
      local hide = timer({ timeout = 5 })

      hide:connect_signal("timeout", function()
        s.Bar.visible = false
        hide:stop()
      end)

      hide:start()
    end
  end)

  Desktop.Bartoggle:connect_signal('mouse::leave', function(self)
    for s in screen do
      s.Bar.visible = true
      ---@diagnostic disable-next-line: undefined-global
      local hide = timer({ timeout = 5 })

      hide:connect_signal("timeout", function()
        s.Bar.visible = false
        hide:stop()
      end)

      hide:start()
    end
  end)
end

local function my_button(text, cb)
  local tb = wibox.widget.textbox(text)
  tb.align = "center"
  tb.valign = "center"
  tb:buttons(awful.button({}, 1, cb))
  return tb
end

local w = wibox { x = 30, y = 30, width = 300, height = 300, ontop = false }
w:setup {
  forced_num_cols = 2,
  forced_num_rows = 2,
  homogeneous = true,
  expand = true,
  layout = wibox.layout.grid,
  my_button("notify", function() naughty.notify { text = "Notify!" } end),
  my_button("close", function() if client.focus then client.focus:kill() end end),
  my_button("quit", function() awesome.quit() end),
  my_button("restart", function() awesome.restart() end)
}
-- w.visible = true

local touchwidget = require('configs.ui.desktop.touchwidgets')
-- touchwidget.toggle()
