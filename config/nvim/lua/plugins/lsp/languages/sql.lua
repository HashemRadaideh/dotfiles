local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .sqlls.setup({
    capabilities = config.capabilities,
    flags = config.flags,
    handlers = config.handlers,
    on_attach = config.on_attach,
})

-- require('lspconfig')
--     .sqls.setup({
--     capabilities = config.capabilities,
--     flags = config.flags,
--     handlers = config.handlers,
--     on_attach = config.on_attach,
--     filetypes = { "plsql" },
-- })
