local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .asm_lsp.setup(config)
