local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .taplo.setup(config)
