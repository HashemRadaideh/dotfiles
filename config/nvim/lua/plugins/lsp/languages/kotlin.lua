local config = require("plugins.lsp.config")

vim.lsp.enable("kotlin_language_server")
vim.lsp.config("kotlin_language_server", {
  capabilities = config.capabilities,
  flags = config.flags,
  -- handlers = config.handlers,
  on_attach = config.on_attach,
})
