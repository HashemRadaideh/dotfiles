local utils = require("plugins.ui.lualine.utils")

return {
  "branch",
  icons_enabled = true,
  -- color = { fg = "#cba6f7" }, -- bg = "grey", gui = "italic,bold"
  -- color = function(section)
  -- 	return { fg = vim.b.gitsigns_head ~= "master" and "#aa3355" or "#33aa88" }
  -- end,
  -- icon = { "", align = "left", color = { fg = "#cba6f7" } }, -- "",
  icon = "",
  cond = utils.hide_in_width,
  always_visible = false,
}