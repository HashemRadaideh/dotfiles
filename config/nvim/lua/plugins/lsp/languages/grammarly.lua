local config = require("plugins.lsp.config")

vim.lsp.enable("grammarly")
vim.lsp.config("grammarly", config)
