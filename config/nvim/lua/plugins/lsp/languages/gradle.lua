local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .gradle_ls.setup({
    capabilities = config.capabilities,
    on_attach = config.on_attach,
    handlers = config.handlers,
    flags = config.flags,
    filetypes = { 'groovy', 'kotlin' },
})
