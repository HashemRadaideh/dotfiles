return {
  "nvim-java/nvim-java",
  ft = { "java" },
  config = function()
    require("java").setup()

    local config = require("plugins.lsp.config")

    vim.lsp.config("jdtls", config)
    vim.lsp.enable("jdtls")
  end,
}
