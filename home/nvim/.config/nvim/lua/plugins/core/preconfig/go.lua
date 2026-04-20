return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  dependencies = {
    { "leoluz/nvim-dap-go", ft = "go", opts = {} },
    "ray-x/guihua.lua",
  },
  opts = {},
}
