local config = require('plugins.lsp.configs.setup')

-- require('lspconfig')
--     .cssls.setup(config)

require('lspconfig')
    .cssmodules_ls.setup(config)

-- require('lspconfig')
--     .unocss.setup(config)

-- require('lspconfig')
--     .tailwindcss.setup(config)
