local config = require("plugins.lsp.config")

vim.lsp.config("biome", {
  capabilities = config.capabilities,
  flags = config.flags,
  handlers = config.handlers,
  on_attach = config.on_attach,
})
vim.lsp.enable("biome")
