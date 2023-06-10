local awful                             = require("awful")
local gears                             = require("gears")
local beautiful                         = require("beautiful")
local naughty                           = require("naughty")
local menubar                           = require("menubar")
local dpi                               = beautiful.xresources.apply_dpi

---@diagnostic disable-next-line: undefined-global
local client                            = client

-- Defaults
naughty.config.defaults.shape           = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius) end

-- Apply theme variables
-- naughty.config.padding                  = beautiful.notification_padding
naughty.config.padding                  = dpi(8)
-- naughty.config.defaults.margin          = beautiful.notification_margin
naughty.config.defaults.margin          = dpi(20)
-- naughty.config.spacing                  = beautiful.notification_spacing
naughty.config.spacing                  = dpi(8)
-- naughty.config.defaults.border_width    = beautiful.notification_border_width
naughty.persistence_enabled             = true
naughty.config.defaults.ontop           = true
-- naughty.config.position                 = beautiful.notification_position
-- naughty.config.font                     = beautiful.notification_font

naughty.config.icon_formats             = { "png", "svg", "jpg" }

-- Icon size
naughty.config.defaults['icon_size']    = beautiful.notification_icon_size

-- Timeouts
naughty.config.timeouts                 = 5
naughty.config.defaults.timeout         = 5
naughty.config.defaults.hover_timeout   = 1
naughty.config.presets.low.timeout      = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.low              = {
  fg           = beautiful.notification_fg,
  bg           = beautiful.notification_bg,
  border_color = beautiful.notification_border_color,
}

naughty.config.presets.info             = naughty.config.presets.low

naughty.config.presets.normal           = {
  fg           = beautiful.notification_fg,
  bg           = beautiful.notification_bg,
  border_color = beautiful.notification_border_color,
}

naughty.config.presets.ok               = naughty.config.presets.low

naughty.config.presets.critical         = {
  fg           = beautiful.notification_crit_fg,
  bg           = beautiful.notification_crit_bg,
  border_color = beautiful.notification_border_color,
}

naughty.config.presets.warn             = naughty.config.presets.normal

local function focus_window_for_notification(pid, appname)
  for _, c in ipairs(client.get()) do
    -- no all apps send pid with the notification (e.g., chrome)
    -- or might send the notification from a different pid
    if pid then
      if c.pid == pid then
        c:jump_to()
        return
      end
      -- this is extremely sketch and might match incorrect clients,
      -- or the wrong window for clients with multiple windows
    elseif c.name:match(appname) then
      c:jump_to()
      return
    end
  end
end

-- Notification callback to style monitoring notification
local real_notify              = naughty.notify
naughty.config.notify_callback = function(args)
  if args.freedesktop_hints and args.freedesktop_hints["desktop-entry"] and args.icon == nil and
      args.freedesktop_hints["image_path"] == nil and args.freedesktop_hints["image-data"] == nil then
    local path = menubar.utils.lookup_icon(args.freedesktop_hints["desktop-entry"]) or
        menubar.utils.lookup_icon(args.freedesktop_hints["desktop-entry"]:lower())
    if path then
      args.icon = path
    end
  end

  if args.title then
    args.title = args.title .. "\n"
  end

  -- if args.app_name and args.message then
  --   local message = gstring.xml_escape(args.message)
  --   -- args.message = gstring.xml_unescape(message)
  --   -- args.message = markup.font("PragmataPro Liga " .. dpi(11.5), message)
  --   args.message = message
  -- end

  -- wrap any action callbacks if the notification has actions
  if args.actions then
    local actions = {}
    for action, callback in pairs(args.actions) do
      actions[action] = function(...)
        local pid = args.freedesktop_hints["sender-pid"]
        focus_window_for_notification(pid, args.appname)
        callback(...)
      end
    end
    args.actions = actions
  end

  -- wrap run function
  local run = args.run
  args.run = function(notification)
    local pid = args.freedesktop_hints["sender-pid"]
    focus_window_for_notification(pid, args.appname)
    -- if user provided run function or there is a default action, run it
    if run then
      run(notification)
    else
      notification.die(naughty.notificationClosedReason.dismissedByUser)
    end
  end

  return args
end

naughty.connect_signal("request::icon", function(n, context, hints)
  if context ~= "app_icon" then return end

  local path = menubar.utils.lookup_icon(hints.app_icon) or
      menubar.utils.lookup_icon(hints.app_icon:lower())

  if path then
    n.icon = path
  end
end)

--- Use XDG icon
naughty.connect_signal("request::action_icon", function(a, context, hints)
  a.icon = menubar.utils.lookup_icon(hints.id)
end)
