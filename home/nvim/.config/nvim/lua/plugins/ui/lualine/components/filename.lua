local utils = require("plugins.ui.lualine.utils")

return {
  "filename",
  path = 0,
  symbols = {
    modified = "●",
    readonly = "",
    unnamed = "[Untitled]",
  },
  cond = utils.hide_buffertypes,
}