local config = require("plugins.lsp.config")

vim.lsp.enable("gradle_ls")
vim.lsp.config("gradle_ls", config)
