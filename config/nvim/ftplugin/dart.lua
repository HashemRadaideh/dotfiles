vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("FixAllCodeAction", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.lsp.buf.code_action(
      {
        context = {
          diagnostics = {},
          only = { "source.fixAll" },
          triggerKind = 1,
        },
        apply = true,
      },
      vim.api.nvim_get_current_buf(),
      {
        start = {
          line = vim.api.nvim_win_get_cursor(0)[1] - 1,
          character = 0,
        },
        ["end"] = {
          line = vim.api.nvim_win_get_cursor(0)[1],
          character = 0,
        },
      }
    )
  end,
})
