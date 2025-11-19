local config = require("plugins.lsp.config")

vim.lsp.enable("cmake")
vim.lsp.config("cmake", config)
