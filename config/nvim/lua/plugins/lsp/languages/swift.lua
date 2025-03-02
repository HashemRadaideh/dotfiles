local config = require("plugins.lsp.config")

config.capabilities = {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
  },
}

require("lspconfig").sourcekit.setup(config)
