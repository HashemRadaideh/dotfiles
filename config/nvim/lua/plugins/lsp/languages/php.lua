local config = require("plugins.lsp.config")

vim.lsp.enable("intelephense")
vim.lsp.config("intelephense", config)
