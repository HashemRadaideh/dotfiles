local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .dartls.setup(config)
