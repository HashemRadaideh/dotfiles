local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .clangd.setup(config)
