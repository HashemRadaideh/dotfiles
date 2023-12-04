local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .matlab_ls.setup(config)

-- require('lspconfig')
--     .matlab_ls.setup({
--     capabilities = config.capabilities,
--     on_attach = config.on_attach,
--     handlers = config.handlers,
--     flags = config.flags,
--     filetypes = { "matlab", "m" }
-- })
