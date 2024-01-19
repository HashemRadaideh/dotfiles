---@diagnostic disable-next-line: undefined-global
local client = client
local awful = require("awful")
local ruled = require("ruled")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule {
    id         = "global",
    rule       = {},
    properties = {
      focus            = awful.client.focus.filter,
      raise            = true,
      -- screen    = awful.screen.preferred,
      screen           = awful.screen.focused,
      placement        = awful.placement.no_overlap +
          awful.placement.no_offscreen,
      size_hints_honor = false,
      honor_workarea   = true,
      honor_padding    = true,
      -- border_width = 2,
      -- border_color = beautiful.border_normal,
      -- keys         = clientkeys,
      -- buttons      = clientbuttons,
    }
  }

  ruled.client.append_rule {
    id         = "floating",
    rule_any   = {
      instance = {
        "copyq",
        "pinentry",
        "Devtools", --- Firefox devtools
      },
      class    = {
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
      },
      name     = {
        "Event Tester", -- xev.
      },
      role     = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
        "GtkFileChooserDialog",
        "devtools",      ---Google Chrome's (detached) Developer Tools.
      },
      type     = {
        "dialog",
      },
    },
    properties = {
      floating = true,
      screen   = awful.screen.focused,
    }
  }

  ruled.client.append_rule {
    rule_any   = { type = { "dialog" } },
    properties = {
      titlebars_enabled = true,
      floating          = true,
      screen            = awful.screen.focused,
      placement         = awful.placement.centered +
          awful.placement.no_offscreen
    }
  }

  ruled.client.append_rule {
    rule_any   = { name = { "Emulator" } },
    properties = {
      titlebars_enabled = true,
      floating          = true,
      screen            = awful.screen.focused,
      placement         = awful.placement.no_overlap +
          awful.placement.no_offscreen
    }
  }

  ruled.client.append_rule {
    rule_any = { name = { "plank" } },
    properties = {
      screen       = awful.screen.focused,
      ontop        = true,
      border_width = 0,
    }
  }

  ruled.client.append_rule {
    id         = "titlebars",
    rule_any   = { type = { "normal" } },
    properties = {
      titlebars_enabled = Titled,
      screen            = awful.screen.focused,
    }
  }

  ruled.client.append_rule {
    rule = { class = "Pavucontrol" },
    properties = {
      titlebars_enabled = true,
      floating          = true,
      screen            = awful.screen.focused,
      placement         = awful.placement.centered +
          awful.placement.no_overlap +
          awful.placement.no_offscreen
    }
  }

  ruled.client.append_rule {
    rule = { class = "DesktopEditors" },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[3],
      titlebars_enabled = false,
    }
  }

  ruled.client.append_rule {
    rule = { class = "firefox" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[2],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Brave" },
    properties = {
      screen = awful.screen.focused,
      tag = Tags[2],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Sidekick-browser" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[2],
    },
    callback = function(c)
      local tags = awful.screen.focused().tags
      local current_tag = tags[2] -- awful.tag.getidx()

      local function is_empty(tag, clt)
        local count = 0

        for _, clnt in pairs(tag:clients()) do
          count = clnt.class == c.class and count + 1 or count
        end

        return count <= 1
      end

      if not is_empty(current_tag, c) then
        for _, tag in pairs(tags) do
          if #tag:clients() == 0 then
            current_tag = tag
            break
          end
        end
      end

      c:move_to_tag(current_tag)
    end
  }

  ruled.client.append_rule {
    rule       = { class = "discord" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[9],
    }
  }

  ruled.client.append_rule {
    rule = { class = "zoom" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[9],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Microsoft Teams - Preview" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[9],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Steam", name = "Steam" },
    properties = {
      titlebars_enabled = false,
      tag = Tags[7],
      screen = awful.screen.focused,
    }
  }

  ruled.client.append_rule {
    rule = { class = "lutris", name = "lutris" },
    properties = {
      titlebars_enabled = false,
      tag = Tags[7],
      screen = awful.screen.focused,
    }
  }

  ruled.client.append_rule {
    rule = { class = "Spotify" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[8],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Xephyr" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[5],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Trello" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[4],
    }
  }

  ruled.client.append_rule {
    rule = { class = "notion-app" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[4],
    }
  }

  ruled.client.append_rule {
    rule = { class = "Evernote" },
    properties = {
      screen = awful.screen.focused,
      tag    = Tags[4],
    }
  }

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
      width    = screen_width * 0.7,
      height   = screen_height * 0.75,
      screen   = awful.screen.focused,
    },
    callback = function(c)
      awful.placement.centered(
        c,
        { honor_padding = true, honor_workarea = true }
      )
    end,
  })

  ruled.client.append_rule {
    rule = { class = "polybar", name = "polybar%-example_HDMI%-1" },
    properties = {
      titlebars_enabled = false,
      screen            = awful.screen.focused,
    }
  }
end)

client.connect_signal("request::manage", function(c)
  if c.class == "Spotify" then
    c:move_to_screen(awful.screen.focused())
    c:move_to_tag(Tags[8])
    local tag = awful.tag.gettags(2)[3]
    if tag then
      awful.tag.viewonly(tag)
    end
  end
end)
