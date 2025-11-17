local config = require("plugins.lsp.config")

vim.lsp.config("matlab_ls", config)
vim.lsp.enable("matlab_ls")
