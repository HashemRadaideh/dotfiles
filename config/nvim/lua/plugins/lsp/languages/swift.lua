local config = require("plugins.lsp.config")

config.capabilities = {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
  },
}

vim.lsp.config("sourcekit", {
  capabilities = config.capabilities,
  flags = config.flags,
  handlers = config.handlers,
  on_attach = config.on_attach,
  filetypes = { "swift", "objc", "objcpp" },
})
vim.lsp.enable("sourcekit")
