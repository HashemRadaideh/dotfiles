return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      width = 120,
    },
    plugins = {
      options = {
        laststatus = 0,
      },
      twilight = {
        enabled = false,
      },
    },
    on_open = function()
      require("package-info").hide()
    end,
  },
  keys = {
    {
      "<leader>zm",
      function()
        vim.cmd([[ZenMode]])
      end,
      desc = "Toggle Zen Mode",
    },
  },
}
