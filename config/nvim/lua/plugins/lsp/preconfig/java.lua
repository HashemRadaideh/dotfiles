return {
  "nvim-java/nvim-java",
  ft = { "java" },
  config = function()
    require("java").setup()

    local config = require("plugins.lsp.config")

    vim.lsp.enable("jdtls")
    vim.lsp.config("jdtls", config)
  end,
}
