local awful = require("awful")
local ruled = require("ruled")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

---@diagnostic disable-next-line: undefined-global
local client, screen = client, screen

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
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
        "GtkFileChooserDialog",
        "devtools", ---Google Chrome's (detached) Developer Tools.
      },
      type     = {
        "dialog",
      },
    },
    properties = { floating = true }
  }

  ruled.client.append_rule {
    rule_any   = { type = { "dialog" } },
    properties = {
      titlebars_enabled = true,
      floating = true,
      placement = awful.placement.centered +
          awful.placement.no_overlap +
          awful.placement.no_offscreen
    }
  }

  ruled.client.append_rule {
    id         = "titlebars",
    rule_any   = { type = { "normal" } },
    properties = { titlebars_enabled = not Is_zen }
  }

  ruled.client.append_rule {
    rule = { class = "Pavucontrol" },
    properties = {
      titlebars_enabled = true,
      floating = true,
      placement = awful.placement.centered +
          awful.placement.no_overlap +
          awful.placement.no_offscreen
    }
  }

  ruled.client.append_rule {
    rule = { class = "DesktopEditors" },
    properties = { tag = screen[1].tags[3], titlebars_enabled = false }
  }

  ruled.client.append_rule {
    rule = { class = "firefox" },
    properties = { tag = screen[1].tags[2] }
  }

  ruled.client.append_rule {
    rule = { class = "Brave" },
    properties = { tag = screen[1].tags[2] }
  }

  ruled.client.append_rule {
    rule = { class = "Google-chrome" },
    properties = { tag = screen[1].tags[2] }
  }

  ruled.client.append_rule {
    rule       = { class = "discord" },
    properties = { tag = screen[1].tags[9] }
  }

  ruled.client.append_rule {
    rule = { class = "zoom" },
    properties = { tag = screen[1].tags[9] }
  }

  ruled.client.append_rule {
    rule = { class = "Microsoft Teams - Preview" },
    properties = { tag = screen[1].tags[9] }
  }

  ruled.client.append_rule {
    rule = { class = "Steam", name = "Steam" },
    properties = { tag = screen[1].tags[7], titlebars_enabled = false }
  }

  ruled.client.append_rule {
    rule = { class = "lutris", name = "lutris" },
    properties = { tag = screen[1].tags[7], titlebars_enabled = false }
  }

  ruled.client.append_rule {
    rule = { class = "Spotify" },
    properties = { tag = screen[1].tags[8] }
  }

  ruled.client.append_rule {
    rule = { class = "Xephyr" },
    properties = { tag = screen[1].tags[5] }
  }

  ruled.client.append_rule {
    rule = { class = "Trello" },
    properties = { tag = screen[1].tags[4] }
  }

  ruled.client.append_rule {
    rule = { class = "notion-app" },
    properties = { tag = screen[1].tags[4] }
  }

  ruled.client.append_rule {
    rule = { class = "Evernote" },
    properties = { tag = screen[1].tags[4] }
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
      width = screen_width * 0.7,
      height = screen_height * 0.75,
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
    properties = { titlebars_enabled = false }
  }
end)

client.connect_signal("property::class", function(c)
  if c.class == "Spotify" then
    c:move_to_screen(8)
    c:move_to_tag(screen[1].tags[8])
    local tag = awful.tag.gettags(2)[3]
    if tag then
      awful.tag.viewonly(tag)
    end
  end
end)
