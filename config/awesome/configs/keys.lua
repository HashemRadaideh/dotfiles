---@diagnostic disable-next-line: undefined-global
local awesome, client, screen = awesome, client, screen
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local gears = require("gears")

-- Default modkey.
Ctrl = "Control"
Meta = "Mod1"
Shift = "Shift"
Super = "Mod4"

local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")

-- Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 1, function()
    Main_menu:hide()
  end),

  awful.button({}, 3, function()
    Main_menu:toggle()
  end),

  awful.button({}, 4, awful.tag.viewnext),

  awful.button({}, 5, awful.tag.viewprev),
})

awful.keyboard.append_global_keybindings({
  awful.key({ Super, Shift }, "/", hotkeys_popup.show_help, { description = "Show help popup", group = "Awesome" }),

  awful.key({ Super, Ctrl }, "r", awesome.restart, { description = "Reload Awesome", group = "Awesome" }),

  awful.key({ Super, Ctrl }, "q", awesome.quit, { description = "Quit awesome", group = "Awesome" }),

  awful.key({ Super, Ctrl }, ";", awesome.quit, { description = "Quit awesome", group = "Awesome" }),

  -- Show/Hide Wibox
  awful.key({ Super }, "b", function()
    if Autohide then
      for s in screen do
        s.Bar.visible = Autohide

        s.Bar.hide:connect_signal("timeout", function()
          if not s.Bar.hover then
            s.Bar.visible = not Autohide
          end
          s.Bar.hide:stop()
        end)

        s.Bar.hide:start()
      end
    end
  end, { description = "Toggle bar visibility", group = "awesome" }),

  awful.key({ Super, Shift }, "b", function()
    -- if Autohide then
    Autohide = not Autohide
    for s in screen do
      s.Bar.visible = not Autohide
    end
    -- end
  end, { description = "Toggle bar visibility", group = "awesome" }),

  awful.key({ Super }, "t", function()
    Titles()
  end, { description = "Toggle titlebars mode", group = "System" }),

  awful.key({ Super }, "z", function()
    ZenSwitch()
  end, { description = "Toggle zen mode", group = "System" }),

  awful.key({ Super, Shift }, "s", function()
    Is_sloppy = not Is_sloppy
  end, { description = "Toggle sloppy focus", group = "System" }),

  -- awful.key(
  --   { Super, }, "/",
  --   function()
  --     Desktop.Side_Panel.visible = not Desktop.Side_Panel.visible
  --   end,
  --   { description = "Toggle side panel visibility", group = "System" }
  -- ),

  awful.key({ Super }, "a", function()
    Task.visible = not Task.visible

    TaskButton.image = Task.visible and beautiful.arrow_left or beautiful.arrow_right
  end, { description = "Toggle active apps list visibility", group = "System" }),

  awful.key({ Super }, "s", function()
    Systray.visible = not Systray.visible

    SystrayButton.image = Systray.visible and beautiful.arrow_right or beautiful.arrow_left
  end, { description = "Toggle systray visibility", group = "System" }),

  awful.key({ Super }, "'", function()
    Main_menu:toggle({ coords = { x = 0, y = 0 } })
  end, { description = "Show main menu", group = "System" }),

  awful.key({ Super }, "Return", function()
    awful.spawn(Terminal_multiplexed)
  end, { description = "Open a terminal with multiplexer", group = "Launch" }),

  awful.key({ Super, Shift }, "Return", function()
    awful.spawn(Terminal_emulator)
  end, { description = "Open a terminal", group = "Launch" }),

  awful.key({ Super }, "r", function()
    awful.spawn('rofi -show drun -theme "themes/launchpad.rasi"')
  end, { description = "Open rofi run prompt", group = "Launch" }),

  awful.key({ Super }, "/", function()
    awful.spawn('rofi -show drun -theme "themes/launchpad.rasi"')
  end, { description = "Open rofi run prompt", group = "Launch" }),

  awful.key({ Super }, "g", function()
    awful.spawn('rofi -show emoji -modi emoji -theme "themes/emojis.rasi"')
  end, { description = "Open rofi run prompt", group = "Launch" }),

  awful.key({ Super, Shift }, "f", function()
    awful.spawn('rofi -show filebrowser -modi filebrowser -theme "themes/launchpad.rasi"')
  end, { description = "Open rofi run prompt", group = "Launch" }),

  awful.key({ Super }, "v", function()
    awful.spawn(
      [[rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -theme "themes/clipboard.rasi"]]
    )
    -- awful.spawn([[clipcat-menu]])
  end, { description = "Open rofi run prompt", group = "Launch" }),

  awful.key({ Super }, "c", function()
    awful.spawn('rofi -show calc -modi calc -no-show-match -no-sort -theme "themes/calculator.rasi" | xclip')
  end, { description = "Open rofi run prompt", group = "Launch" }),

  awful.key({ Super }, "d", function()
    awful.spawn.with_shell("dmenu_run")
  end, { description = "Open dmenu run prompt", group = "Launch" }),

  awful.key({ Super }, "o", function()
    awful.spawn.with_shell(Terminal_file_manager)
  end, { description = "Open lf", group = "Launch" }),

  awful.key({ Super }, "e", function()
    awful.spawn.with_shell(File_manager)
  end, { description = "Open file manger", group = "Launch" }),

  awful.key({}, "Print", function()
    awful.spawn.with_shell("screenshot")
  end, { description = "Screenshot whole screen", group = "System" }),

  awful.key({ Super }, "Print", function()
    awful.spawn.with_shell("screenshot focused")
  end, { description = "Screenshot focused window", group = "System" }),

  awful.key({ Shift }, "Print", function()
    awful.spawn.with_shell("screenshot selected")
  end, { description = "Screenshot a selected area", group = "System" }),

  awful.key({ Super }, "x", function()
    awful.spawn.with_shell("lock")
  end, { description = "Lock screen", group = "System" }),

  awful.key({ Super, Shift }, "x", function()
    IdleInhibitor:emit_signal("button::press")
  end, { description = "Toggle screen idle", group = "System" }),

  awful.key({ Super }, "f", function()
    if client.focus then
      client.focus.fullscreen = not client.focus.fullscreen
      client.focus:raise()
    end
  end, { description = "Toggle fullscreen", group = "System" }),

  awful.key({ Super }, "p", function()
    logout_popup.launch({
      onlock = function()
        awful.spawn.with_shell("lock")
      end,
    })
  end, { description = "Show power menu", group = "System" }),

  awful.key({ Super }, ".", function()
    awful.screen.focus_relative(1)
  end, { description = "Focus next screen", group = "Workspace" }),

  awful.key({ Super }, ",", function()
    awful.screen.focus_relative(-1)
  end, { description = "Focus previous screen", group = "Workspace" }),

  awful.key({ Super }, "Tab", awful.tag.viewnext, { description = "View next tag", group = "Workspace" }),

  awful.key({ Super, Shift }, "Tab", awful.tag.viewprev, { description = "View previous tag", group = "Workspace" }),

  -- awful.key(
  --   { Super }, "i",
  --   function()
  --     Desktop.Tasks.visible = not Desktop.Tasks.visible

  --     hide:connect_signal("timeout", function()
  --       Desktop.Tasks.visible = not Desktop.Tasks.visible
  --       hide:stop()
  --     end)

  --     hide:start()

  --     awful.client.focus.history.previous()
  --     -- awful.client.focus.byidx(1)

  --     if client.focus then
  --       client.focus:raise()
  --     end

  --     -- if awful.client.ismarked() then
  --     --   awful.screen.focus_relative(-1)
  --     --   awful.client.getmarked()
  --     -- end

  --     -- awful.client.togglemarked()
  --   end,
  --   { description = "Focus previous client", group = "System" }
  -- ),

  awful.key({ Super }, "u", awful.tag.history.restore, { description = "Go to last focused client", group = "System" }),

  awful.key(
    { Super, Shift },
    "u",
    awful.client.urgent.jumpto,
    { description = "Focus urgent client", group = "System" }
  ),

  awful.key({ Super, Ctrl, Shift }, "n", function()
    local c = awful.client.restore()
    if c then
      c:activate({ raise = true, context = "key.unminimize" })
    end
  end, { description = "Restore minimized", group = "System" }),

  awful.key({ Super }, "=", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "Increase the number of columns", group = "Workspace" }),

  awful.key({ Super }, "-", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "Decrease the number of columns", group = "Workspace" }),

  awful.key({ Super, Ctrl }, "=", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "Increase the number of columns", group = "Workspace" }),

  awful.key({ Super, Ctrl }, "-", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "Decrease the number of columns", group = "Workspace" }),

  -- Move focus between clients by global direction
  awful.key({ Super }, "h", function()
    awful.client.focus.global_bydirection("left")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Focus client to the left", group = "Workflow" }),

  awful.key({ Super }, "j", function()
    awful.client.focus.global_bydirection("down")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Focus client to the bottom", group = "Workflow" }),

  awful.key({ Super }, "k", function()
    awful.client.focus.global_bydirection("up")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Focus client to the top", group = "Workflow" }),

  awful.key({ Super }, "l", function()
    awful.client.focus.global_bydirection("right")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Focus client to the right", group = "Workflow" }),

  -- Swap focused client by global direction
  awful.key({ Super, Ctrl }, "h", function()
    awful.client.swap.global_bydirection("left")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Move client to the left", group = "Workflow" }),

  awful.key({ Super, Ctrl }, "j", function()
    awful.client.swap.global_bydirection("down")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Move client to the bottom", group = "Workflow" }),

  awful.key({ Super, Ctrl }, "k", function()
    awful.client.swap.global_bydirection("up")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Move client to the top", group = "Workflow" }),

  awful.key({ Super, Ctrl }, "l", function()
    awful.client.swap.global_bydirection("right")
    if client.focus then
      client.focus:raise()
    end
  end, { description = "Move client to the right", group = "Workflow" }),

  -- modify the client size
  awful.key({ Super, Shift }, "h", function()
    if client.focus.floating then
      client.focus:relative_move(0, 0, -10, 0)
    else
      awful.tag.incmwfact(-0.025)
    end
  end, { description = "Decrease master width factor", group = "Workflow" }),

  awful.key({ Super, Shift }, "j", function()
    if client.focus.floating then
      client.focus:relative_move(0, 0, 0, 10)
    else
      awful.client.incwfact(0.025)
    end
  end, { description = "Increase master width factor", group = "Workflow" }),

  awful.key({ Super, Shift }, "k", function()
    if client.focus.floating then
      client.focus:relative_move(0, 0, 0, -10)
    else
      awful.client.incwfact(-0.025)
    end
  end, { description = "Decrease master width factor", group = "Workflow" }),

  awful.key({ Super, Shift }, "l", function()
    if client.focus.floating then
      client.focus:relative_move(0, 0, 10, 0)
    else
      awful.tag.incmwfact(0.025)
    end
  end, { description = "Increase master width factor", group = "Workflow" }),

  -- Moving floating windows
  awful.key({ Super, Meta }, "h", function()
    client.focus:relative_move(-10, 0, 0, 0)
  end, { description = "Move floating client to the left", group = "Workflow" }),

  awful.key({ Super, Meta }, "j", function()
    client.focus:relative_move(0, 10, 0, 0)
  end, { description = "Move floating client to the down", group = "Workflow" }),

  awful.key({ Super, Meta }, "k", function()
    client.focus:relative_move(0, -10, 0, 0)
  end, { description = "Move floating client to the top", group = "Workflow" }),

  awful.key({ Super, Meta }, "l", function()
    client.focus:relative_move(10, 0, 0, 0)
  end, { description = "Move floating client to the right", group = "Workflow" }),

  -- Change layout
  awful.key({ Super }, "]", function()
    awful.layout.inc(1)
  end, { description = "Select next layout", group = "Workflow" }),

  awful.key({ Super }, "[", function()
    awful.layout.inc(-1)
  end, { description = "Select previous layout", group = "Workflow" }),

  awful.key({ Super }, "i", function()
    awful.util.spawn([[playerctl play-pause ]])
  end, { description = "Increase volume", group = "Media" }),

  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.util.spawn([[media up]])
  end, { description = "Increase volume", group = "Media" }),

  awful.key({}, "XF86AudioLowerVolume", function()
    awful.util.spawn([[media down]])
  end, { description = "Decrease volume", group = "Media" }),

  awful.key({}, "XF86AudioMute", function()
    awful.util.spawn([[media mute]])
  end, { description = "Mute volume", group = "Media" }),

  awful.key({}, "XF86AudioMicMute", function()
    awful.util.spawn([[media micmute]])
  end, { description = "Mute volume", group = "Media" }),

  awful.key({}, "XF86MonBrightnessUp", function()
    awful.util.spawn([[brightness up]])
  end, { description = "Increase brightness", group = "Media" }),

  awful.key({}, "XF86MonBrightnessDown", function()
    awful.util.spawn([[brightness down]])
  end, { description = "Decrease brightness", group = "Media" }),

  awful.key({}, "XF86AudioPrev", function()
    awful.util.spawn([[playerctl previous ]])
  end, { description = "Increase volume", group = "Media" }),

  awful.key({}, "XF86Calculator", function()
    awful.spawn('rofi -show calc -modi calc -no-show-match -no-sort -theme "themes/calculator.rasi" | xclip')
  end, { description = "Increase volume", group = "Media" }),

  awful.key({}, "XF86AudioNext", function()
    awful.util.spawn([[ playerctl next ]])
  end, { description = "Increase volume", group = "Media" }),

  awful.key({}, "XF86AudioPlay", function()
    awful.util.spawn([[ playerctl play-pause ]])
  end, { description = "Increase volume", group = "Media" }),

  awful.key({}, "XF86AudioStop", function()
    awful.util.spawn([[ playerctl stop ]])
  end, { description = "Increase volume", group = "Media" }),

  awful.key({
    modifiers = { Super },
    keygroup = "numrow",
    description = "Focus tag",
    group = "Workflow",
    on_press = function(index)
      local scrn = awful.screen.focused()
      local tag = index == 0 and scrn.tags[10] or scrn.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),

  awful.key({
    modifiers = { Super, Shift },
    keygroup = "numrow",
    description = "Toggle tag viewablity",
    group = "Workflow",
    on_press = function(index)
      local scrn = awful.screen.focused()
      local tag = index == 0 and scrn.tags[10] or scrn.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),

  awful.key({
    modifiers = { Ctrl, Super },
    keygroup = "numrow",
    description = "Move focused client to tag",
    group = "Workflow",
    on_press = function(index)
      if client.focus then
        local tag = index == 0 and client.focus.screen.tags[10] or client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),

  awful.key({
    modifiers = { Super, Ctrl, Shift },
    keygroup = "numrow",
    description = "Toggle focused client on tag",
    group = "Workflow",
    on_press = function(index)
      if client.focus then
        local tag = index == 0 and client.focus.screen.tags[10] or client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),

  awful.key({
    modifiers = { Super },
    keygroup = "numpad",
    description = "Select layout directly",
    group = "Workflow",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }),
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),

    awful.button({}, 3, function(c)
      c:activate({ context = "mouse_click" })
    end),

    awful.button({ Super }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),

    awful.button({ Super }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })

  awful.keyboard.append_client_keybindings({
    awful.key({}, "F11", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "Toggle fullscreen", group = "System" }),

    awful.key({ Super }, ";", function(c)
      c:kill()
    end, { description = "Close Focused client", group = "System" }),

    awful.key({ Super }, "q", function(c)
      c:kill()
    end, { description = "Close Focused client", group = "System" }),

    awful.key(
      { Super, Meta },
      "Return",
      awful.client.floating.toggle,
      { description = "Toggle floating", group = "Workspace" }
    ),

    awful.key({ Super, Ctrl }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, { description = "Set focused client as master", group = "Workspace" }),

    awful.key({ Super, Ctrl }, ".", function(c)
      c:move_to_screen(c.screen.index + 1)
    end, { description = "Move to screen", group = "Workspace" }),

    awful.key({ Super, Ctrl }, ",", function(c)
      c:move_to_screen(c.screen.index - 1)
    end, { description = "Move to screen", group = "Workspace" }),

    awful.key({ Super }, "y", function(c)
      c.ontop = not c.ontop
    end, { description = "Keep floating client on top", group = "Workspace" }),

    awful.key({ Super, Ctrl }, "n", function(c)
      c.minimized = true
    end, { description = "Minimize focused client", group = "System" }),

    awful.key({ Super, Ctrl }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "(Un)Maximize Focused client", group = "System" }),

    awful.key({ Super, Shift }, "=", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, { description = "(Un)Maximize vertically", group = "Workspace" }),

    awful.key({ Super, Shift }, "-", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, { description = "(Un)Maximize horizontally", group = "Workspace" }),
  })
end)
