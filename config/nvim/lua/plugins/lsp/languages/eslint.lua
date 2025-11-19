local config = require("plugins.lsp.config")

vim.lsp.enable("eslint")
vim.lsp.config("eslint", {
  capabilities = config.capabilities,
  flags = config.flags,
  handlers = config.handlers,
  on_attach = function(client, bufnr)
    config.on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
