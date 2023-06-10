pcall(require, "luarocks.loader")
require('awful.autofocus')

local gears = require("gears")
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "configs/theme.lua")

Autohide = true
Is_zen = true
Is_titled = false
Is_sloppy = false

require('configs')
