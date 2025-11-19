local config = require("plugins.lsp.config")

vim.lsp.enable("bashls")
vim.lsp.config("bashls", config)
