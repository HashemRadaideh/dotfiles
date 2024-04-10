return {
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
      "github:nvim-java/mason-registry",
      "github:mason-org/mason-registry",
    },
  },
}
