local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .intelephense.setup(config)
