local config = require("plugins.lsp.config")

vim.lsp.enable("mesonlsp")
vim.lsp.config("mesonlsp", config)
