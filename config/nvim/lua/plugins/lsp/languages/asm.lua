local config = require("plugins.lsp.config")

vim.lsp.config("asm_lsp", config)
vim.lsp.enable("asm_lsp")
