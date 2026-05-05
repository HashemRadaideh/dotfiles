local utils = require("plugins.ui.lualine.utils")

return {
  "location",
  cond = utils.hide_in_width,
  always_visible = false,
}