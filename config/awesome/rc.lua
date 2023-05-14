pcall(require, "luarocks.loader")
require('awful.autofocus')

local gears = require("gears")
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "configs/theme.lua")

-- Focus mode (style mode)
Is_zen = false
Is_titled = false
Is_sloppy = true
Autohide = false

require('configs')
