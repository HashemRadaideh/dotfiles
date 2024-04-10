return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      debug = false,
      sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.selene,

        -- go
        -- null_ls.builtins.formatting.gofumpt,

        -- rust
        -- null_ls.builtins.formatting.rustfmt,
        -- null_ls.builtins.formatting.leptosfmt,

        -- c/cpp
        -- null_ls.builtins.formatting.clang_format,
        --cmake
        -- null_ls.builtins.formatting.cmake_format,
        null_ls.builtins.formatting.shfmt,

        -- ruby
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.diagnostics.rubocop,

        -- kotlin
        null_ls.builtins.diagnostics.ktlint,

        -- javascript
        -- null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.prettierd,

        -- python
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.diagnostics.isort,
        null_ls.builtins.formatting.djhtml.with({
          filetypes = { "django", "jinja.html", "htmldjango", "jsp" },
        }),

        -- sql
        -- null_ls.builtins.formatting.sqlformat,
        -- null_ls.builtins.formatting.sqlfmt,
        null_ls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "mysql" },
        }),
        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "mysql" }, -- change to your dialect
        }),

        -- null_ls.builtins.code_actions.gitsigns,
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
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
          })
        end
      end,
    })
  end,
}
