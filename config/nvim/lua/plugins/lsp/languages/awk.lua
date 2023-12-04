local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .awk_ls.setup(config)
