local utils = require("plugins.ui.lualine.utils")

return {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " },
  cond = utils.hide_in_width,
}