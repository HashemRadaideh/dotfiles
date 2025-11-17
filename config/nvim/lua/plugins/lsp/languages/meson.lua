local config = require("plugins.lsp.config")

vim.lsp.config("mesonlsp", config)
vim.lsp.enable("mesonlsp")
