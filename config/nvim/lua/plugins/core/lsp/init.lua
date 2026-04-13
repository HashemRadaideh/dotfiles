return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 90,
    dependencies = {
      { "ray-x/lsp_signature.nvim" },
      { "SmiteshP/nvim-navic" },
      { "antosha417/nvim-lsp-file-operations", opts = {} },
      -- { "j-hui/fidget.nvim", opts = {} },
    },
    config = require("plugins.core.lsp.config"),
  },
  require("plugins.core.lsp.preconfig"),
}
