local config = require("plugins.lsp.config")

vim.lsp.enable("asm_lsp")
vim.lsp.config("asm_lsp", config)
