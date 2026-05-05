local utils = require("plugins.ui.lualine.utils")

return {
  function()
    local project = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local branch = vim.b.gitsigns_head or ""
    if branch ~= "" then
      project = project .. "  " .. branch
    end
    return project
  end,
  cond = utils.hide_in_width,
}