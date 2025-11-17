local config = require("plugins.lsp.config")

vim.lsp.config("bashls", config)
vim.lsp.enable("bashls")
