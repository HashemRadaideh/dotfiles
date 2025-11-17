local config = require("plugins.lsp.config")

vim.lsp.config("zls", config)
vim.lsp.enable("zls")
