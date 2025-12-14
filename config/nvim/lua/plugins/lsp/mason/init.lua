return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>mm",
        "<cmd>Mason<CR>",
        { noremap = true, silent = true },
      },
    },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:nvim-java/mason-registry",
        "github:crashdummyy/mason-registry",
      },
    },
  },
  require("plugins.lsp.mason.lspconfig"),
  require("plugins.lsp.mason.tool-installer"),
}
