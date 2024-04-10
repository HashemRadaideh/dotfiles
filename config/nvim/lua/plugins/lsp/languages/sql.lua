local config = require("plugins.lsp.config")

require("lspconfig").sqlls.setup(config)

-- require('lspconfig')
--     .sqls.setup({
--     capabilities = config.capabilities,
--     flags = config.flags,
--     handlers = config.handlers,
--     on_attach = config.on_attach,
--     filetypes = { "plsql" },
-- })
