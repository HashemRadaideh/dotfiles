return {
  -- {
  --   "tpope/vim-fugitive",
  --   cmd = "G",
  -- },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
