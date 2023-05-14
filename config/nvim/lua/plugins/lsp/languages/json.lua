local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .jsonls.setup(config)
