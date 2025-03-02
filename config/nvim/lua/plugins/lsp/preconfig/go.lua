return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  dependencies = {
    { "leoluz/nvim-dap-go", ft = "go", opts = {} },
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
}
