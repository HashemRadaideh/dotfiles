return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    handlers = {
      rust_analyzer = false,
    },
  },
}
