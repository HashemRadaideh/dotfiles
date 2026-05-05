return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    keys = {
      {
        "<leader>mm",
        "<cmd>Mason<CR>",
        { noremap = true, silent = true },
      },
    },
    opts = {},
  },
  require("plugins.core.mason.extensions"),
}