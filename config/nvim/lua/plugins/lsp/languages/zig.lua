local config = require("plugins.lsp.config")

vim.lsp.enable("zls")
vim.lsp.config("zls", config)
