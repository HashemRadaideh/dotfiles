local config = require("plugins.lsp.config")

require("lspconfig").lua_ls.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      workspace = { checkThirdParty = false },
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      telemetry = { enable = false },
    },
  },
})
