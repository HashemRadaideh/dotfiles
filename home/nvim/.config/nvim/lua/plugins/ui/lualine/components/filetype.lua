local utils = require("plugins.ui.lualine.utils")

return {
  "filetype",
  icons_enabled = true,
  always_visible = true,
  icon_only = false,
  colored = true,
  cond = utils.hide_buffertypes,
}