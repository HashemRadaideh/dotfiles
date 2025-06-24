local config = require("plugins.lsp.config")

require("lspconfig").gleam.setup({
  capabilities = config.capabilities,
  flags = config.flags,
  handlers = config.handlers,
  on_attach = config.on_attach,
})
