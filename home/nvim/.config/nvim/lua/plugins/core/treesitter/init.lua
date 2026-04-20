return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local parsers = require("nvim-treesitter.parsers")

      local to_install = vim.tbl_filter(function(lang)
        local p = parsers[lang]
        return p and not p.experimental
      end, vim.tbl_keys(parsers))

      ts.install(to_install):wait(60000)
    end,
  },
  require("plugins.core.treesitter.playground"),
  require("plugins.core.treesitter.autotag"),
  require("plugins.core.treesitter.autopair"),
  require("plugins.core.treesitter.comment"),
  require("plugins.core.treesitter.todo"),
  require("plugins.core.treesitter.delimiter"),
  require("plugins.core.treesitter.treesj"),
}
