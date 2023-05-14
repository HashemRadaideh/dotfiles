local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

null_ls.setup({
  debug = true,
  sources = {
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.rustfmt,
    -- null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.djhtml.with({
      filetypes = { "django", "jinja.html", "htmldjango", "jsp", },
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "jsx",
        "typescript",
        "tsx",
        "css",
        "sass",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
        "md",
        "txt",
      },
    }),
    null_ls.builtins.formatting.cmake_format,
    null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      ---@diagnostic disable-next-line: undefined-global
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        ---@diagnostic disable-next-line: undefined-global
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
