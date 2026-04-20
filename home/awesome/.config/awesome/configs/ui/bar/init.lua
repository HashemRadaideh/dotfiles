local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

---@diagnostic disable-next-line: unused-local
local menu = require("configs.ui.bar.menu")
local layoutbox = require("configs.ui.bar.layoutbox")
local tags_list = require("configs.ui.bar.tagslist")
local mode_toggle = require("configs.ui.bar.modetoggle")
local tasks = require("configs.ui.bar.tasks")

---@diagnostic disable-next-line: unused-local
local shape = require("configs.ui.bar.shape")
local clock = require("configs.ui.bar.clock")

local systray = require("configs.ui.bar.systray")
-- ---@diagnostic disable-next-line: unused-local
-- local net = require("configs.ui.bar.net")
-- ---@diagnostic disable-next-line: unused-local
-- local cpu = require("configs.ui.bar.cpu")
-- ---@diagnostic disable-next-line: unused-local
-- local mem = require("configs.ui.bar.ram")
-- local bluetooth = require("configs.ui.bar.bluetooth")
-- local network = require("configs.ui.bar.network")
local volume_widget = require("awesome-wm-widgets.pactl-widget.volume")
-- local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
-- local battery = require("configs.ui.bar.battery")
local idle_inhibitor = require("configs.ui.bar.idleinhibitor")
local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")

local clickable_container = require("configs.ui.bar.clickable-container")

-- local wifi = network()

screen.connect_signal("request::desktop_decoration", function(s)
  s.bar = awful.wibar({
    hide = gears.timer({ timeout = 2.5 }),
    hover = false,
    visible = true,
    screen = s,
    type = "dock",
    ontop = false,
    stretch = false,
    bg = beautiful.bg,
    height = dpi(31),
    width = s.geometry.width - beautiful.border_width * 2,
    position = "top",
    align = "center",
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    widget = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
        layout = wibox.layout.fixed.horizontal,
        {
          {
            menu,
            margins = { left = dpi(8), top = dpi(8), bottom = dpi(8), right = dpi(5) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        {
          {
            layoutbox,
            margins = { left = dpi(1), top = dpi(5), bottom = dpi(5), right = dpi(3) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        {
          {
            mode_toggle,
            margins = { left = dpi(3), top = dpi(5), bottom = dpi(5), right = dpi(3) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        tags_list(s),
        {
          {
            tasks.tasks_button,
            margins = { left = dpi(0), top = dpi(0), bottom = dpi(0), right = dpi(0) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        tasks.tasks_list[s],
      },
      -- {
      --   layout = wibox.layout.fixed.horizontal,
      --   shape(beautiful.arrow_left),
      --   {
      --     {
      --       clock,
      --       margins = { left = dpi(5), right = dpi(5) },
      --       widget = wibox.container.margin,
      --     },
      --     widget = clickable_container,
      --   },
      --   shape(beautiful.arrow_right),
      -- },
      {
        layout = wibox.layout.fixed.horizontal,
      },
      {
        layout = wibox.layout.fixed.horizontal,
        systray.systray,
        {
          {
            systray.systray_button,
            margins = { left = dpi(0), top = dpi(0), bottom = dpi(0), right = dpi(0) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        {
          {
            clock,
            margins = { left = dpi(5), right = dpi(5) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        -- net.net,
        -- {
        --   {
        --     net.net_button,
        --     margins = { left = dpi(4), top = dpi(4), bottom = dpi(4), right = dpi(4) },
        --     widget = wibox.container.margin,
        --   },
        --   widget = clickable_container,
        -- },
        -- mem.mem,
        -- {
        --   {
        --     mem.mem_button,
        --     margins = { left = dpi(4), top = dpi(6), bottom = dpi(6), right = dpi(4) },
        --     widget = wibox.container.margin,
        --   },
        --   widget = clickable_container,
        -- },
        -- cpu.cpu,
        -- {
        --   {
        --     cpu.cpu_button,
        --     margins = { left = dpi(4), top = dpi(6), bottom = dpi(6), right = dpi(4) },
        --     widget = wibox.container.margin,
        --   },
        --   widget = clickable_container,
        -- },
        -- bluetooth,
        -- wifi,
        {
          volume_widget({
            widget_type = "arc", -- icon_and_text
            step = 1,
          }),
          widget = clickable_container,
        },
        -- {
        --   {
        --     brightness_widget({
        --       -- type = 'icon_and_text',
        --       type = "arc",
        --       program = "brightnessctl",
        --       step = 1,
        --     }),
        --     margins = { left = dpi(5), right = dpi(5) },
        --     widget = wibox.container.margin,
        --   },
        --   widget = clickable_container,
        -- },
        -- battery(),
        {
          {
            idle_inhibitor,
            margins = { left = dpi(5), top = dpi(7), bottom = dpi(7), right = dpi(3) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
        {
          {
            logout_popup.widget({
              onlock = function()
                awful.spawn.with_shell("lock")
              end,
            }),
            margins = { left = dpi(2), top = dpi(5), bottom = dpi(5), right = dpi(5) },
            widget = wibox.container.margin,
          },
          widget = clickable_container,
        },
      },
    },
  })

  if Autohide then
    s.bar.hide:start()
  end

  s.bar:connect_signal("mouse::enter", function()
    s.bar_toggle.visible = false
    s.bar.hover = true
    s.bar.hide:stop()
    s.bar.border_color = beautiful.border_focus
    s.bar.visible = true
  end)

  s.bar:connect_signal("mouse::leave", function()
    s.bar.hover = false
    s.bar.border_color = beautiful.border_normal

    s.bar.hide:connect_signal("timeout", function()
      if not s.bar.hover then
        s.bar_toggle.visible = Autohide
        s.bar.visible = not Autohide
      end
      s.bar.hide:stop()
    end)

    s.bar.hide:start()
  end)

  s.bar.hide:connect_signal("timeout", function()
    if not s.bar.hover then
      s.bar_toggle.visible = Autohide
      s.bar.visible = not Autohide
    end
    s.bar.hide:stop()
  end)
end)
