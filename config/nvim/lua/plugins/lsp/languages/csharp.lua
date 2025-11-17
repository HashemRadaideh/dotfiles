local config = require("plugins.lsp.config")

vim.lsp.config("omnisharp", {
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
vim.lsp.enable("omnisharp")
-- .csharp_ls.setup(config)
-- .omnisharpmono.setup(config)

vim.cmd([[autocmd BufNewFile,BufRead *.cshtml set filetype=html.cshtml.razor]])
vim.cmd([[autocmd BufNewFile,BufRead *.razor set filetype=html.cshtml.razor]])
