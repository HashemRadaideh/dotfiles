local utils = require("plugins.ui.lualine.utils")

return {
  function()
    return "spaces: " .. vim.bo[vim.api.nvim_get_current_buf()].shiftwidth
  end,
  cond = utils.hide_in_width,
}