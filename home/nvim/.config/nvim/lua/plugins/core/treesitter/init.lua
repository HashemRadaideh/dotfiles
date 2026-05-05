return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = require("plugins.core.treesitter.config"),
  },
  require("plugins.core.treesitter.extensions"),
}