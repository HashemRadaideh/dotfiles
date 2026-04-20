vim.cmd([[autocmd BufNewFile,BufRead *.cshtml set filetype=html.cshtml.razor]])
vim.cmd([[autocmd BufNewFile,BufRead *.razor set filetype=html.cshtml.razor]])

return {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
}
