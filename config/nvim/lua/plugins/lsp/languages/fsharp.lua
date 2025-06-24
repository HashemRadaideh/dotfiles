local config = require("plugins.lsp.config")

require("lspconfig").fsautocomplete.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  init_options = {
    AutomaticWorkspaceInit = true,
  },
})
