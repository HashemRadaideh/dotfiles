local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .rust_analyzer.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
})
