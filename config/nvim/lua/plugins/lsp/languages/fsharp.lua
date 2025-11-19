local config = require("plugins.lsp.config")

vim.lsp.enable("fsautocomplete")
vim.lsp.config("fsautocomplete", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  init_options = {
    AutomaticWorkspaceInit = true,
  },
})
