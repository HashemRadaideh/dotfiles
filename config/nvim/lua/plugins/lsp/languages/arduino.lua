local config = require("plugins.lsp.config")

vim.lsp.enable("arduino_language_server")
vim.lsp.config("arduino_language_server", config)
