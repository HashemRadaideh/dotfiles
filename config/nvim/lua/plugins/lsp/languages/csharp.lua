local config = require("plugins.lsp.config")

require("lspconfig").omnisharp.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
})
-- .csharp_ls.setup(config)
-- .omnisharpmono.setup(config)
