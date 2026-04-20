local awful = require("awful")
local beautiful = require("beautiful")

awful.mouse.snap.edge_enabled = true

client.connect_signal("manage", function(c)
  -- Set the windows at the stack,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then
    awful.client.setslave(c)
  end

  -- Prevent clients from being unreachable after screen count changes.
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

-- Rounded Borders and no border for maximized clients
local function border_adjust(c)
  if Autohide and c.fullscreen then
    if c.screen.bar_toggle then
      c.screen.bar_toggle.visible = false
    end

    if c.screen.bar.hide then
      c.screen.bar.hide:stop()
    end
  else
    if c.screen.bar_toggle then
      c.screen.bar_toggle.visible = true
    end

    if c.screen.bar.hide then
      c.screen.bar.hide:start()
    end
  end

  -- if #awful.screen.focused().clients > 1 then
  --   c.border_width = beautiful.border_width
  -- else
  --   c.border_width = 0
  -- end
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
    c:activate({ context = "mouse_enter", raise = true })
  end
end)
client.connect_signal("request::manage", function(c)
  if Titles then
    awful.titlebar.show(c)
  else
    awful.titlebar.hide(c)
  end
end)

function Titled()
  Titles = not Titles

  if Titles then
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
end

function Gapped()
  Gaps = not Gaps

  for _, t in ipairs(root.tags()) do
    awful.tag.incgap(Gaps and -beautiful.useless_gap_size or beautiful.useless_gap_size, t)
  end
end

Gapped()
