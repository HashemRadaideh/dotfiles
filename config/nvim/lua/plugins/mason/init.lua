return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
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
  require("plugins.mason.dap"),
  require("plugins.mason.lspconfig"),
  require("plugins.mason.tool-installer"),
}
