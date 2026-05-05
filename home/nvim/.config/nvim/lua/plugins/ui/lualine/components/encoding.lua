local utils = require("plugins.ui.lualine.utils")

-- local encoding = {
--   "encoding",
--   -- fmt = function(str)
--   --   return "encoding: " .. str
--   -- end,
--   cond = hide_in_width,
--   always_visible = false,
-- }

return {
  "encoding",
  cond = utils.hide_in_width,
  always_visible = false,
}