local config = require("plugins.lsp.config")

vim.lsp.config("arduino_language_server", config)
vim.lsp.enable("arduino_language_server")
