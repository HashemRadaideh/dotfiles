local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .csharp_ls.setup(config)
