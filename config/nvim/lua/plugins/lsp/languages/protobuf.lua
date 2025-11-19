local config = require("plugins.lsp.config")

-- vim.lsp.enable("buf_ls")
-- vim.lsp.config("buf_ls",  config)
vim.lsp.enable("protols")
vim.lsp.config("protols", config)
-- vim.lsp.enable("pbls")
-- vim.lsp.config("pbls",  config)
