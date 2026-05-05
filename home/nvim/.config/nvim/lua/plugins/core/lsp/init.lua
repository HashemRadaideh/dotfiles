return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = require("plugins.core.lsp.config"),
  },
  require("plugins.core.lsp.extensions"),
}