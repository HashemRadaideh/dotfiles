local config = require("plugins.lsp.config")

vim.lsp.enable("vimls")
vim.lsp.config("vimls", config)
