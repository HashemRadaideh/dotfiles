local config = require("plugins.lsp.config")

vim.lsp.enable("gleam")
vim.lsp.config("gleam", {
  capabilities = config.capabilities,
  flags = config.flags,
  handlers = config.handlers,
  on_attach = config.on_attach,
})
