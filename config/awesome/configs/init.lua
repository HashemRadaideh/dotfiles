require("beautiful").init(require("gears").filesystem.get_configuration_dir() .. Theme)
-- autostart applications
-- require("awful").spawn.easy_async_with_shell("autostart")
require("awful").spawn.easy_async_with_shell("dex -as $XDG_CONFIG_HOME/autostart")
require('configs.notifications')
require('configs.keys')
require('configs.rules')
require('configs.ui')
