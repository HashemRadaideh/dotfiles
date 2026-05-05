local utils = require("plugins.ui.lualine.utils")

return {
  function()
    local cwd = vim.fn.getcwd()
    return vim.fn.fnamemodify(cwd, ":t")
  end,
  icon = "",
  cond = utils.hide_in_width,
}