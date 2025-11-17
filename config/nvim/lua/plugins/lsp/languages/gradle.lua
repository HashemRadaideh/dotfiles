local config = require("plugins.lsp.config")

vim.lsp.config("gradle_ls", config)
vim.lsp.enable("gradle_ls")
