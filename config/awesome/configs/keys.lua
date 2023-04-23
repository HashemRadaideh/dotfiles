local awful                   = require('awful')
local hotkeys_popup           = require('awful.hotkeys_popup')
local beautiful               = require('beautiful')

---@diagnostic disable-next-line: undefined-global
local awesome, client, screen = awesome, client, screen

-- Default modkey.
Ctrl                          = "Control"
Meta                          = "Mod1"
Shift                         = "Shift"
Super                         = "Mod4"

local logout_popup            = require(
  "awesome-wm-widgets.logout-popup-widget.logout-popup"
)

-- Mouse bindings
awful.mouse.append_global_mousebindings(
  {
    awful.button(
      {}, 1,
      function() Main_menu:hide() end
    ),

    awful.button(
      {}, 3,
      function() Main_menu:toggle() end
    ),

    awful.button(
      {}, 4,
      awful.tag.viewnext
    ),

    awful.button(
      {}, 5,
      awful.tag.viewprev
    )
  }
)

awful.keyboard.append_global_keybindings(
  {
    awful.key(
      { Super, Shift }, "/",
      hotkeys_popup.show_help,
      { description = "Show help popup", group = "Awesome" }
    ),

    awful.key(
      { Super, Ctrl }, "r",
      awesome.restart,
      { description = "Reload Awesome", group = "Awesome" }
    ),

    awful.key(
      { Super, Ctrl }, "q",
      awesome.quit,
      { description = "Quit awesome", group = "Awesome" }
    ),

    -- Show/Hide Wibox
    awful.key(
      { Super }, "b",
      function()
        if Autohide then
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
        end
      end,
      { description = "Toggle bar visibility", group = "awesome" }
    ),

    awful.key(
      { Super, Shift }, "b",
      function()
        if Autohide then
          for s in screen do
            s.Bar.visible = not s.Bar.visible
          end
        end
      end,
      { description = "Toggle bar visibility", group = "awesome" }
    ),

    awful.key(
      { Super }, "t",
      function()
        ZenSwitch()
        if Is_zen then
          ModeToggle.image = beautiful.mode_icon
        else
          ModeToggle.image = beautiful.mode_icon_active
        end
      end,
      { description = "Toggle titlebars mode", group = "System" }
    ),

    awful.key(
      { Super, Shift }, "s",
      function()
        if Is_sloppy then
          Is_sloppy = false
        else
          Is_sloppy = true
        end
      end,
      { description = "Toggle sloppy focus", group = "System" }
    ),

    -- awful.key(
    --   { Super, }, "/",
    --   function()
    --     Desktop.Side_Panel.visible = not Desktop.Side_Panel.visible
    --   end,
    --   { description = "Toggle side panel visibility", group = "System" }
    -- ),

    awful.key(
      { Super, }, "a",
      function()
        Task.visible = not Task.visible

        if Task.visible then
          TaskButton.image = beautiful.arrow_left
        else
          TaskButton.image = beautiful.arrow_right
        end
      end,
      { description = "Toggle active apps list visibility", group = "System" }
    ),

    awful.key(
      { Super, }, "s",
      function()
        Systray.visible = not Systray.visible

        if Systray.visible then
          SystrayButton.image = beautiful.arrow_right
        else
          SystrayButton.image = beautiful.arrow_left
        end
      end,
      { description = "Toggle systray visibility", group = "System" }
    ),

    -- awful.key(
    --   { Meta }, "b",
    --   function() awful.spawn.with_shell("browsers") end,
    --   { description = "Select browser", group = "Launch" }
    -- ),

    awful.key(
      { Super }, "'",
      function() Main_menu:toggle { coords = { x = 0, y = 0 } } end,
      { description = "Show main menu", group = "System" }
    ),

    awful.key(
      { Super }, "Return",
      function() awful.spawn(Terminal_multiplexed) end,
      { description = "Open a terminal with multiplexer", group = "Launch" }
    ),

    awful.key(
      { Super, Shift }, "Return",
      function() awful.spawn(Terminal_emulator) end,
      { description = "Open a terminal", group = "Launch" }
    ),

    awful.key(
      { Super }, "/",
      function() awful.spawn.with_shell("rofi -no-lazy-grab -show drun") end,
      { description = "Open rofi run prompt", group = "Launch" }
    ),

    awful.key(
      { Super }, "r",
      function() awful.spawn.with_shell("rofi -no-lazy-grab -show drun") end,
      { description = "Open rofi run prompt", group = "Launch" }
    ),

    awful.key(
      { Super }, "d",
      function() awful.spawn.with_shell("dmenu_run") end,
      { description = "Open dmenu run prompt", group = "Launch" }
    ),

    awful.key(
      { Super }, "c",
      function() awful.spawn.with_shell("code") end,
      { description = "Open vscode", group = "Launch" }
    ),

    awful.key(
      { Super }, "v",
      function() awful.spawn.with_shell(Graphical_editor) end,
      { description = "Open emacs", group = "Launch" }
    ),

    awful.key(
      { Super }, "e",
      function() awful.spawn.with_shell(Terminal_editor) end,
      { description = "Open nvim", group = "Launch" }
    ),

    awful.key(
      { Super }, "o",
      function() awful.spawn.with_shell(Terminal_file_manager) end,
      { description = "Open lf", group = "Launch" }
    ),

    awful.key(
      { Super }, "f",
      function() awful.spawn.with_shell(File_manager) end,
      { description = "Open thunar", group = "Launch" }
    ),

    awful.key(
      { Ctrl, }, "Print",
      function() awful.spawn.with_shell("screenshot") end,
      { description = "Screenshot whole screen", group = "System" }
    ),

    awful.key(
      { Super, }, "Print",
      function() awful.spawn.with_shell("screenshot focused") end,
      { description = "Screenshot focused window", group = "System" }
    ),

    awful.key(
      { Shift, }, "Print",
      function() awful.spawn.with_shell("screenshot selected") end,
      { description = "Screenshot a selected area", group = "System" }
    ),

    awful.key(
      { Super, }, "x",
      function() awful.spawn.with_shell("lock") end,
      { description = "Lock screen", group = "System" }
    ),

    awful.key(
      { Super }, "p",
      function()
        logout_popup.launch({
          onlock = function() awful.spawn.with_shell("lock") end,
          onsuspend = function()
            awful.spawn.with_shell("lock && systemctl suspend")
          end
        })
      end,
      { description = "Show power menu", group = "System" }
    ),

    awful.key(
      { Super }, ".",
      function() awful.screen.focus_relative(1) end,
      { description = "Focus next screen", group = "Workspace" }
    ),

    awful.key(
      { Super }, ",",
      function() awful.screen.focus_relative(-1) end,
      { description = "Focus previous screen", group = "Workspace" }
    ),

    awful.key(
      { Super }, "Tab",
      awful.tag.viewnext,
      { description = "View next tag", group = "Workspace" }
    ),

    awful.key(
      { Super, Shift }, "Tab",
      awful.tag.viewprev,
      { description = "View previous tag", group = "Workspace" }
    ),

    -- awful.key(
    --   { Super }, "i",
    --   function()
    --     Desktop.Tasks.visible = not Desktop.Tasks.visible

    --     ---@diagnostic disable-next-line: undefined-global
    --     local hide = timer({ timeout = 1 })

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

    -- awful.key(
    --   { Super }, "u",
    --   awful.tag.history.restore,
    --   { description = "Go to last focused client", group = "System" }
    -- ),

    awful.key(
      { Meta }, "u",
      awful.client.urgent.jumpto,
      { description = "Focus urgent client", group = "System" }
    ),

    awful.key(
      { Super, Ctrl }, "n",
      function()
        local c = awful.client.restore()
        if c then
          c:activate { raise = true, context = "key.unminimize" }
        end
      end,
      { description = "Restore minimized", group = "System" }
    ),

    awful.key(
      { Super }, "=",
      function() awful.tag.incnmaster(1, nil, true) end,
      { description = "Increase the number of columns", group = "Workspace" }
    ),

    awful.key(
      { Super }, "-",
      function() awful.tag.incnmaster(-1, nil, true) end,
      { description = "Decrease the number of columns", group = "Workspace" }
    ),

    awful.key(
      { Super, Ctrl }, "=",
      function() awful.tag.incncol(1, nil, true) end,
      { description = "Increase the number of columns", group = "Workspace" }
    ),

    awful.key(
      { Super, Ctrl }, "-",
      function() awful.tag.incncol(-1, nil, true) end,
      { description = "Decrease the number of columns", group = "Workspace" }
    ),

    -- Move focus between clients by global direction
    awful.key(
      { Super }, "h",
      function()
        awful.client.focus.global_bydirection("left")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Focus client to the left", group = "Workflow" }
    ),

    awful.key(
      { Super }, "j",
      function()
        awful.client.focus.global_bydirection("down")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Focus client to the bottom", group = "Workflow" }
    ),

    awful.key(
      { Super }, "k",
      function()
        awful.client.focus.global_bydirection("up")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Focus client to the top", group = "Workflow" }
    ),

    awful.key(
      { Super }, "l",
      function()
        awful.client.focus.global_bydirection("right")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Focus client to the right", group = "Workflow" }
    ),

    -- Swap focused client by global direction
    awful.key(
      { Super, Ctrl }, "h",
      function()
        awful.client.swap.global_bydirection("left")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Move client to the left", group = "Workflow" }
    ),

    awful.key(
      { Super, Ctrl }, "j",
      function()
        awful.client.swap.global_bydirection("down")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Move client to the bottom", group = "Workflow" }
    ),

    awful.key(
      { Super, Ctrl }, "k",
      function()
        awful.client.swap.global_bydirection("up")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Move client to the top", group = "Workflow" }
    ),

    awful.key(
      { Super, Ctrl }, "l",
      function()
        awful.client.swap.global_bydirection("right")
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = "Move client to the right", group = "Workflow" }
    ),

    -- modify the client size
    awful.key(
      { Super, Shift }, "h",
      function()
        if client.focus.floating then
          client.focus:relative_move(0, 0, -10, 0)
        else
          awful.tag.incmwfact(-0.025)
        end
      end,
      { description = "Decrease master width factor", group = "Workflow" }
    ),

    awful.key(
      { Super, Shift }, "j",
      function()
        if client.focus.floating then
          client.focus:relative_move(0, 0, 0, 10)
        else
          awful.client.incwfact(0.025)
        end
      end,
      { description = "Increase master width factor", group = "Workflow" }
    ),

    awful.key(
      { Super, Shift }, "k",
      function()
        if client.focus.floating then
          client.focus:relative_move(0, 0, 0, -10)
        else
          awful.client.incwfact(-0.025)
        end
      end,
      { description = "Decrease master width factor", group = "Workflow" }
    ),

    awful.key(
      { Super, Shift }, "l",
      function()
        if client.focus.floating then
          client.focus:relative_move(0, 0, 10, 0)
        else
          awful.tag.incmwfact(0.025)
        end
      end,
      { description = "Increase master width factor", group = "Workflow" }
    ),

    -- Moving floating windows
    awful.key(
      { Super, Meta }, "h",
      function() client.focus:relative_move(-10, 0, 0, 0) end,
      { description = "Move floating client to the left", group = "Workflow" }
    ),

    awful.key(
      { Super, Meta }, "j",
      function() client.focus:relative_move(0, 10, 0, 0) end,
      { description = "Move floating client to the down", group = "Workflow" }
    ),

    awful.key(
      { Super, Meta }, "k",
      function() client.focus:relative_move(0, -10, 0, 0) end,
      { description = "Move floating client to the top", group = "Workflow" }
    ),

    awful.key(
      { Super, Meta }, "l",
      function() client.focus:relative_move(10, 0, 0, 0) end,
      { description = "Move floating client to the right", group = "Workflow" }
    ),

    -- Change layout
    awful.key(
      { Super }, "]",
      function() awful.layout.inc(1) end,
      { description = "Select next layout", group = "Workflow" }
    ),

    awful.key(
      { Super }, "[",
      function() awful.layout.inc(-1) end,
      { description = "Select previous layout", group = "Workflow" }
    ),

    -- awful.key(
    --   { Super, }, "]",
    --   function() awful.util.spawn("amixer -D pulse sset Master 5%+") end,
    --   { description = "Increase volume", group = "Media" }
    -- ),

    -- awful.key(
    --   { Super, }, "[",
    --   function() awful.util.spawn("amixer -D pulse sset Master 5%-") end,
    --   { description = "Decrease volume", group = "Media" }
    -- ),

    awful.key(
      {}, "XF86AudioRaiseVolume",
      function() awful.spawn.with_shell("pamixer -i 3") end,
      { description = "Increase volume", group = "Media" }
    ),

    awful.key(
      {}, "XF86AudioLowerVolume",
      function() awful.spawn.with_shell("pamixer -d 3") end,
      { description = "Decrease volume", group = "Media" }
    ),

    awful.key(
      {}, "XF86AudioMute",
      function() awful.spawn.with_shell("pamixer -t") end,
      { description = "Mute volume", group = "Media" }
    ),

    awful.key(
      {}, "XF86MonBrightnessUp",
      function() awful.spawn.with_shell("brightnessctl set 3%+") end,
      { description = "Increase brightness", group = "Media" }
    ),

    awful.key(
      {}, "XF86MonBrightnessDown",
      function() awful.spawn.with_shell("brightnessctl set 3%-") end,
      { description = "Decrease brightness", group = "Media" }
    ),

    awful.key {
      modifiers = { Super },
      keygroup = "numrow",
      description = "Focus tag",
      group = "Workflow",
      on_press = function(index)
        local scrn = awful.screen.focused()
        local tag = scrn.tags[index]
        if index == 0 then
          tag = scrn.tags[10]
        end
        if tag then
          tag:view_only()
        end
      end
    },

    awful.key {
      modifiers = { Super, Shift },
      keygroup = "numrow",
      description = "Toggle tag viewablity",
      group = "Workflow",
      on_press = function(index)
        local scrn = awful.screen.focused()
        local tag = scrn.tags[index]
        if index == 0 then
          tag = scrn.tags[10]
        end
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end
    },

    awful.key {
      modifiers = { Ctrl, Super, },
      keygroup = "numrow",
      description = "Move focused client to tag",
      group = "Workflow",
      on_press = function(index)
        if client.focus then
          local tag = client.focus.screen.tags[index]
          if index == 0 then
            tag = client.focus.screen.tags[10]
          end
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end
    },

    awful.key {
      modifiers = { Super, Ctrl, Shift },
      keygroup = "numrow",
      description = "Toggle focused client on tag",
      group = "Workflow",
      on_press = function(index)
        if client.focus then
          local tag = client.focus.screen.tags[index]
          if index == 0 then
            tag = client.focus.screen.tags[10]
          end
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end
    },

    awful.key {
      modifiers = { Super },
      keygroup = "numpad",
      description = "Select layout directly",
      group = "Workflow",
      on_press = function(index)
        local t = awful.screen.focused().selected_tag
        if t then
          t.layout = t.layouts[index] or t.layout
        end
      end
    },
  }
)

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings(
    {
      awful.button(
        {}, 1,
        function(c)
          c:activate { context = "mouse_click" }
        end
      ),

      awful.button(
        {}, 3,
        function(c)
          c:activate { context = "mouse_click" }
        end
      ),

      awful.button(
        { Super }, 1,
        function(c)
          c:activate { context = "mouse_click", action = "mouse_move" }
        end
      ),

      awful.button(
        { Super }, 3,
        function(c)
          c:activate { context = "mouse_click", action = "mouse_resize" }
        end
      )
    }
  )

  awful.keyboard.append_client_keybindings(
    {
      awful.key(
        { Super, }, "F11",
        function(c)
          c.fullscreen = not c.fullscreen
          c:raise()
        end,
        { description = "Toggle fullscreen", group = "System" }
      ),

      awful.key(
        { Super }, ";",
        function(c) c:kill() end,
        { description = "Close Focused client", group = "System" }
      ),

      awful.key(
        { Super }, "q",
        function(c) c:kill() end,
        { description = "Close Focused client", group = "System" }
      ),

      awful.key(
        { Super, Meta }, "Return",
        awful.client.floating.toggle,
        { description = "Toggle floating", group = "Workspace" }
      ),

      awful.key(
        { Super, Ctrl }, "Return",
        function(c) c:swap(awful.client.getmaster()) end,
        { description = "Set focused client as master", group = "Workspace" }
      ),

      awful.key(
        { Super, Ctrl }, ".",
        function(c) c:move_to_screen(c.screen.index + 1) end,
        { description = "Move to screen", group = "Workspace" }
      ),

      awful.key(
        { Super, Ctrl }, ",",
        function(c) c:move_to_screen(c.screen.index - 1) end,
        { description = "Move to screen", group = "Workspace" }
      ),

      awful.key(
        { Super }, "y",
        function(c) c.ontop = not c.ontop end,
        { description = "Keep floating client on top", group = "Workspace" }
      ),

      awful.key(
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
        { Super }, "n",
        function(c) c.minimized = true end,
        { description = "Minimize focused client", group = "System" }
      ),

      awful.key(
        { Super }, "m",
        function(c)
          c.maximized = not c.maximized
          c:raise()
        end,
        { description = "(Un)Maximize Focused client", group = "System" }
      ),

      awful.key(
        { Super, Shift, }, "=",
        function(c)
          c.maximized_vertical = not c.maximized_vertical
          c:raise()
        end,
        { description = "(Un)Maximize vertically", group = "Workspace" }
      ),

      awful.key(
        { Super, Shift, }, "-",
        function(c)
          c.maximized_horizontal = not c.maximized_horizontal
          c:raise()
        end,
        { description = "(Un)Maximize horizontally", group = "Workspace" }
      ),
    }
  )
end)
