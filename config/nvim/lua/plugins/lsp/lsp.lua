
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    { "ray-x/lsp_signature.nvim" },
    { "SmiteshP/nvim-navic" },
    { "antosha417/nvim-lsp-file-operations", opts = {} },
    -- { "j-hui/fidget.nvim", opts = {} },
  },
  config = require("plugins.lsp.config"),
}
