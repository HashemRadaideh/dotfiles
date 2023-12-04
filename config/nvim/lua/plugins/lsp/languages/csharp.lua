local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .omnisharp.setup(config)
    -- .omnisharpmono.setup(config)
    -- .csharp_ls.setup(config)
