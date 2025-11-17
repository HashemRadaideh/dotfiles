local config = require("plugins.lsp.config")

-- vim.lsp.config("rubocop",  config)
-- vim.lsp.enable("rubocop")
vim.lsp.config("ruby_lsp", config)
vim.lsp.enable("ruby_lsp")
