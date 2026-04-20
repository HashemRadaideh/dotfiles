return function()
  local parsers = require("nvim-treesitter.parsers")
  local to_install = vim.tbl_filter(function(lang)
    local p = parsers[lang]
    return p and not p.experimental
  end, vim.tbl_keys(parsers))

  require("nvim-treesitter").install(to_install)
end
