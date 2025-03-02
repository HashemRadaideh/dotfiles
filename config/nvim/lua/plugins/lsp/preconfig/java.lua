return {
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  -- },
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "nvim-java/nvim-java-refactor",
    },
    config = function()
      local config = require("plugins.lsp.config")

      require("java").setup()
      require("lspconfig").jdtls.setup(config)
    end,
  },
}
