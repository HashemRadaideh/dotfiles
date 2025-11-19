local config = require("plugins.lsp.config")

vim.lsp.enable("svelte")
vim.lsp.config("svelte", config)
