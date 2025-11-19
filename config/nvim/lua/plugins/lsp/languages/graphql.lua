local config = require("plugins.lsp.config")

vim.lsp.enable("graphql")
vim.lsp.config("graphql", config)
