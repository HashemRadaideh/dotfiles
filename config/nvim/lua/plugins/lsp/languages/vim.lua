local config = require("plugins.lsp.config")

vim.lsp.config("vimls", config)
vim.lsp.enable("vimls")
