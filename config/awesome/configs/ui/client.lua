---@diagnostic disable-next-line: undefined-global
local awesome, client, root = awesome, client, root
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local ruled = require("ruled")

-- Fix window snapping
awful.mouse.snap.edge_enabled = true

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the stack,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then awful.client.setslave(c) end

  -- Prevent clients from being unreachable after screen count changes.
  if awesome.startup and not
      c.size_hints.user_position and not
      c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

function Titles()
  if not Titled then
    for _, c in ipairs(client.get()) do
      if not c.maximized then
        awful.titlebar.show(c)
      end
    end
  else
    for _, c in ipairs(client.get()) do
      awful.titlebar.hide(c)
    end
  end

  ruled.client.append_rule {
    id         = "titlebars",
    rule_any   = { type = { "normal" } },
    properties = { titlebars_enabled = not Titled }
  }

  Titled = not Titled
end

function ZenSwitch()
  if not Zen then
    for _, t in ipairs(root.tags()) do
      awful.tag.incgap(8, t)
    end
  else
    for _, t in ipairs(root.tags()) do
      awful.tag.incgap(-8, t)
    end
  end

  -- if Is_zen then
  --   ModeToggle.image = beautiful.mode_icon
  -- else
  --   ModeToggle.image = beautiful.mode_icon_active
  -- end

  Zen = not Zen
end

ZenSwitch()

-- Rounded Borders and no border for maximized clients
local function border_adjust(c)
  if #awful.screen.focused().clients > 1 then
    c.border_width = beautiful.border_width
  else
    c.border_width = 0
  end

  -- if Zen then
  --   if c.maximized or c.fullscreen then
  --     c.border_width = 0
  --     c.shape = nil
  --   else
  --     c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 15) end
  --   end
  -- else
  --   c.shape = nil
  -- end

  if Autohide and c.fullscreen and c == client.focus then
    c.screen.Bartoggle.ontop = false
    c.screen.Bar.visible = false
    c.screen.Bar.hide:stop()
  else
    c.screen.Bartoggle.ontop = true
  end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("unfocus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("property::fullscreen", border_adjust)
client.connect_signal("property::urgent", function(c)
  border_adjust(c)
  c:jump_to()
end)
client.connect_signal("mouse::enter", function(c)
  border_adjust(c)
  if Sloppy then
    c:emit_signal("request::activate", "mouse_enter", { raise = true })
  end
end)
