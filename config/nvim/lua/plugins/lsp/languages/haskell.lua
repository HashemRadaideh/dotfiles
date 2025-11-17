local config = require("plugins.lsp.config")

vim.lsp.config("hls", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
})
vim.lsp.enable("hls")
