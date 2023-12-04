local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .gopls.setup({
    capabilities = config.capabilities,
    flags = config.flags,
    handlers = config.handlers,
    on_attach = config.on_attach,
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})
