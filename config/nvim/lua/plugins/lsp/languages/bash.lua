local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .bashls.setup({
    capabilities = config.capabilities,
    on_attach = config.on_attach,
    handlers = config.handlers,
    flags = config.flags,
    -- filetypes = { "sh", "zsh", "bash" }
})