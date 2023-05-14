local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .pylsp.setup(config)
