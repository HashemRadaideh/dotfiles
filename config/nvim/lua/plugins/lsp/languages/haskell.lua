local config = require("plugins.lsp.config")

vim.lsp.enable("hls")
vim.lsp.config("hls", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
})
