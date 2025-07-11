local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

function Shape(img)
  return wibox.widget.imagebox(img)
end

-- Left region widgets

Menu = wibox.widget.imagebox(beautiful.menu_icon)

Menu:connect_signal("button::press", function()
  Main_menu:toggle({ coords = { x = 0, y = 0 } })
end)

-- Tasklist
function Tasks(s)
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

TaskButton = wibox.widget.imagebox(beautiful.arrow_right)

TaskButton:connect_signal("button::press", function(self)
  Task.visible = not Task.visible

  if Task.visible then
    self.image = beautiful.arrow_left
  else
    self.image = beautiful.arrow_right
  end
end)

-- Center region widgets

-- layoutBox
Layoutbox = wibox.widget({
  {
    widget = awful.widget.layoutbox,
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end),
  },
})

-- Taglist/Workspaces
function Tagslist(s)
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

local function get_image()
  if Autohide and not Gaps and not Titles and not Sloppy then
    return beautiful.mode_zen
  elseif not Autohide and Gaps and Titles and Sloppy then
    return beautiful.mode_casual
  else
    return beautiful.mode_custom
  end
end

ModeToggle = wibox.widget.imagebox(get_image())

ModeToggle:connect_signal("update_ui", function(self)
  self.prev = self.mode or "zen"
  if Autohide and Gaps and not Titles and not Sloppy then
    self.image = beautiful.mode_zen
    self.mode = "zen"
  elseif not Autohide and not Gaps and Titles and Sloppy then
    self.image = beautiful.mode_casual
    self.mode = "casual"
  else
    self.image = beautiful.mode_custom
    self.mode = "custom"
  end
end)

ModeToggle:connect_signal("button::press", function(self)
  if self.mode == "custom" and self.prev == "zen" then
    Autohide = false
    if Gaps then
      Gapped()
    end
    Titles = true
    Sloppy = true
  elseif self.mode == "custom" and self.prev == "casual" then
    Autohide = true
    if not Gaps then
      Gapped()
    end
    Titles = false
    Sloppy = false
  end

  Autohide = not Autohide
  for s in screen do
    if Autohide then
      s.Bar.hide:start()
    else
      s.Bar.visible = not Autohide
    end
  end

  Gapped()

  Titled()

  Sloppy = not Sloppy

  self:emit_signal("update_ui")
end)

-- Right region widgets

-- -- Textclock
Clock = wibox.widget({ widget = wibox.widget.textbox })

gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    Clock.markup = "<span foreground='" .. "#ffffff" .. "'>" .. os.date("%a, %d %b %H:%M ") .. "</span>" -- 24 hour
    -- os.date("%a %d %b, %I:%M %p ") .. "</span>" -- 12 hours
  end,
})

-- local mytextclock = wibox.widget.textclock()

---@diagnostic disable-next-line: unused-local
local clock_tooltip = awful.tooltip({
  objects = { Clock },
  timer_function = function()
    return os.date("Today is %A %B %d %Y\nThe time is %T")
  end,
  -- delay_show     = 1,
})

Systray = wibox.widget({
  widget = wibox.widget.systray(),
  bg = beautiful.bg_transparent,
  shape = gears.shape.rounded_rect,
  shape_clip = true,
  visible = false,
})

SystrayButton = wibox.widget.imagebox(beautiful.arrow_left)

SystrayButton:connect_signal("button::press", function(self)
  Systray.visible = not Systray.visible

  self.image = Systray.visible and beautiful.arrow_right or beautiful.arrow_left
end)

local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")

CPU = wibox.widget({
  widget = wibox.container.margin,
  visible = false,
  left = 10,
  top = 2,
  bottom = 2,
  right = 10,
  cpu_widget({
    width = 70,
    step_width = 2,
    step_spacing = 0,
    color = "#434c5e",
  }),
})

CPUButton = wibox.widget({
  {
    widget = wibox.widget.imagebox(beautiful.cpu_icon),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

CPUButton:connect_signal("button::press", function()
  CPU.visible = not CPU.visible
end)

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

MEM = wibox.widget({
  widget = wibox.container.margin,
  visible = false,
  left = 10,
  top = 2,
  bottom = 2,
  right = 10,
  ram_widget(),
})

MEMButton = wibox.widget({
  {
    widget = wibox.widget.imagebox(beautiful.mem_icon),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

MEMButton:connect_signal("button::press", function()
  MEM.visible = not MEM.visible
end)

local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")

NET = wibox.widget({
  widget = wibox.container.margin,
  visible = false,
  left = 10,
  top = 2,
  bottom = 2,
  right = 10,
  net_speed_widget(),
})

NETButton = wibox.widget({
  {
    widget = wibox.widget.imagebox(beautiful.net_icon),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

NETButton:connect_signal("button::press", function()
  NET.visible = not NET.visible
end)

local volume_widget = require("awesome-wm-widgets.volume-widget.volume")

Volume = wibox.widget({
  {
    widget = volume_widget({
      -- widget_type = 'icon_and_text'
      widget_type = "arc",
      step = 1,
    }),
  },
  margins = { left = dpi(5), right = dpi(3) },
  widget = wibox.container.margin,
})

local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

Brightness = wibox.widget({
  {
    widget = brightness_widget({
      -- type = 'icon_and_text',
      type = "arc",
      program = "brightnessctl",
      step = 1,
    }),
  },
  margins = { left = dpi(5), right = dpi(5) },
  widget = wibox.container.margin,
})

local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

-- local battery_widget = require(
--   "awesome-wm-widgets.battery-widget.battery"
-- )

function Battery()
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

IdleInhibitor = wibox.widget({
  margins = { left = dpi(3), right = dpi(3) },
  halign = "center",
  valign = "center",
  text = Idle and " " or " ",
  widget = wibox.widget.textbox,
})

local tooltip = awful.tooltip({
  objects = { IdleInhibitor },
  text = Idle and "Currently keeping the system active. Click to allow sleep."
    or "Currently allowing the system to sleep. Click to keep active.",
  mode = "outside", -- Optional, you can use "outside" to make it appear outside the widget
  align = "right", -- Optional, aligns the tooltip
})

IdleInhibitor:connect_signal("button::press", function(self)
  awful.spawn.with_shell("toggleidle")

  Idle = not Idle

  if Idle then
    self.text = " "
    tooltip.text = "Currently keeping the system active. Click to allow sleep."
  else
    self.text = " "
    tooltip.text = "Currently allowing the system to sleep. Click to keep active."
  end
end)

local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")

Logout = wibox.widget({
  {
    widget = logout_popup.widget({
      onlock = function()
        awful.spawn.with_shell("lock")
      end,
    }),
  },
  margins = { left = dpi(3), right = dpi(3) },
  widget = wibox.container.margin,
})
