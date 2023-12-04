local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .arduino_language_server.setup(config)
