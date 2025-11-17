local config = require("plugins.lsp.config")

vim.lsp.config("kotlin_language_server", {
  capabilities = config.capabilities,
  flags = config.flags,
  -- handlers = config.handlers,
  on_attach = config.on_attach,
})
vim.lsp.enable("kotlin_language_server")
