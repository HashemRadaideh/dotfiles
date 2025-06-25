local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()
  local screen_width = awful.screen.focused().geometry.width
  local screen_height = awful.screen.focused().geometry.height

  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      titlebars_enabled = Titles,
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.focused,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false,
      honor_workarea = true,
      honor_padding = true,
    },
  })

  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      instance = {
        "copyq",
        "pinentry",
        "Devtools",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "Lxappearance",
        "Nm-connection-editor",
        "Network",
        "network",
        "blueberry",
        "blueberry.py",
        "Blueberry",
        "Blueberry.py",
        "pavucontrol",
      },
      name = {
        "Event Tester", -- xev.
        "Emulator",
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
        "GtkFileChooserDialog",
        "devtools", ---Google Chrome's (detached) Developer Tools.
      },
      type = {
        "dialog",
      },
    },
    properties = {
      titlebars_enabled = true,
      floating = true,
      screen = awful.screen.focused,
      placement = awful.placement.centered + awful.placement.no_offscreen,
    },
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "feh",
        "imv",
        "nomacs",
        "Image Lounge",
      },
    },
    properties = {
      floating = true,
      width = screen_width * 0.7,
      height = screen_height * 0.75,
      screen = awful.screen.focused,
    },
    callback = function(c)
      awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
    end,
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "firefox",
        "floorp",
        "Brave",
        "Google-chrome",
        "Sidekick-browser",
        "zen",
      },
    },
    properties = {
      screen = awful.screen.focused,
    },
    callback = function(c)
      ---@diagnostic disable-next-line: unused-local
      local function is_empty(tag, clt)
        local count = 0

        for _, clnt in pairs(tag:clients()) do
          count = clnt.class == c.class and count + 1 or count
        end

        return count <= 1
      end

      if c.transient_for and c.name ~= "Picture-in-Picture" then
        c:move_to_tag(c.transient_for.first_tag)
        return
      end

      local tags = awful.screen.focused().tags
      local current_tag = tags[awful.tag.getidx()]

      if not is_empty(current_tag, c) then
        for _, tag in pairs(tags) do
          if #tag:clients() == 0 then
            current_tag = tag
            break
          end
        end
      end

      c:move_to_tag(current_tag)
    end,
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "DesktopEditors",
        "Zathura",
        "org.pwmt.zathura",
        "libreoffice",
        "freeoffice",
        "[oO]pen[oO]ffice.*",
      },
    },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[3],
      titlebars_enabled = false,
    },
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "Trello",
        "notion-app",
        "obsidian",
        "Evernote",
        "thunderbird",
        "Mail",
      },
    },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[4],
    },
  })

  ruled.client.append_rule({
    rule_any = { class = "Xephyr" },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[5],
    },
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "zoom",
        "Microsoft Teams - Preview",
      },
    },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[6],
    },
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "Steam",
        "lutris",
        "heroic",
      },
      name = {
        "Steam",
        "lutris",
      },
    },
    properties = {
      tag = Tags[8],
      screen = awful.screen.focused,
      titlebars_enabled = false,
    },
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "Spotify",
        "spotify",
        "Spotube",
        "spotube",
      },
    },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[9],
    },
  })

  ruled.client.append_rule({
    rule_any = {
      class = {
        "discord",
        "telegram-desktop",
        "TelegramDesktop",
        "whatsie",
        "WhatSie",
        "caprine",
        "Caprine",
      },
    },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[10],
    },
  })
end)

client.connect_signal("request::manage", function(c)
  if c.class == "Spotify" or c.class == "spotify" or c.class == "Spotube" or c.class == "spotube" then
    c:move_to_screen(awful.screen.focused())
    c:move_to_tag(Tags[8])
    local tag = awful.tag.gettags(2)[3]
    if tag then
      awful.tag.viewonly(tag)
    end
  end
end)
