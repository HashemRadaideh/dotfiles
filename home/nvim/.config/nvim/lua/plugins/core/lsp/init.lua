return {
  {
    "neovim/nvim-lspconfig",
    config = require("plugins.core.lsp.config"),
  },
  require("plugins.core.lsp.extensions"),
}
