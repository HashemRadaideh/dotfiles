local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .kotlin_language_server.setup(config)
