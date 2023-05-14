local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .grammarly.setup(config)
