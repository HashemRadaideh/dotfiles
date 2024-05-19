local naughty = require("naughty")

require("configs.notifications.error")
require("configs.notifications.default")

local noti = {}

noti.notification = nil

function noti:notify(message, preset)
  if self.notification and not self.notification.is_expired then
    self.notification.message = tostring(message)
  else
    if not preset then
      preset = naughty.config.presets.low
    end
    self.notification = naughty.notification({
      preset = preset,
      message = tostring(message),
    })
  end
end
