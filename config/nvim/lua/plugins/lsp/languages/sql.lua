local config = require("plugins.lsp.config")

vim.lsp.enable("sqlls")
vim.lsp.config("sqlls", config)

-- require('lspconfig')
--     .sqls.setup({
--     capabilities = config.capabilities,
--     flags = config.flags,
--     handlers = config.handlers,
--     on_attach = config.on_attach,
--     filetypes = { "plsql" },
-- })
