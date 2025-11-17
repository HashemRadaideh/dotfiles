local config = require("plugins.lsp.config")

vim.lsp.config("sqlls", config)
vim.lsp.enable("sqlls")

-- require('lspconfig')
--     .sqls.setup({
--     capabilities = config.capabilities,
--     flags = config.flags,
--     handlers = config.handlers,
--     on_attach = config.on_attach,
--     filetypes = { "plsql" },
-- })
