local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .zls.setup(config)
