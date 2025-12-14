vim.cmd([[autocmd BufNewFile,BufRead *.cshtml set filetype=html.cshtml.razor]])
vim.cmd([[autocmd BufNewFile,BufRead *.razor set filetype=html.cshtml.razor]])
-- .csharp_ls.setup(config)
-- .omnisharpmono.setup(config)

return {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
}
