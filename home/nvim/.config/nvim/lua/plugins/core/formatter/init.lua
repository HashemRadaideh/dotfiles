return {
  "stevearc/conform.nvim",
  event = { "BufReadPost" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fn",
      function()
        require("conform").format()
      end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
  opts = require("plugins.core.formatter.config"),
}
