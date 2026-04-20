require("configs.notifications")

require("beautiful").init(require("gears").filesystem.get_configuration_dir() .. Theme)
require("configs.ui")
require("configs.keys")
require("configs.rules")

pcall(function()
  local naughty = require("naughty")
  naughty.dbus = function() end
end)
