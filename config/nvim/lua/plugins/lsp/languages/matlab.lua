local config = require("plugins.lsp.config")

vim.lsp.enable("matlab_ls")
vim.lsp.config("matlab_ls", config)
