local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .vimls.setup(config)
