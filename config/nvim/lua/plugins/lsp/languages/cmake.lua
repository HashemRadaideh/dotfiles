local config = require("plugins.lsp.config")

vim.lsp.config("cmake", config)
vim.lsp.enable("cmake")
