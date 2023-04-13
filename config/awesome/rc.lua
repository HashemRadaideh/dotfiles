pcall(require, "luarocks.loader")
require('awful.autofocus')

local gears = require("gears")
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "configs/theme.lua")

Autohide = false
require('configs')

gears.timer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage("collect")
  end,
}

gears.timer.start_new(
  600,
  function()
    collectgarbage("step", 1024)
    return true
  end
)
