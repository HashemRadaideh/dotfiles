require("dap").adapters.dart = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
  args = { "flutter" },
}

require("dap").configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/opt/flutter/bin/",
    flutterSdkPath = "/opt/flutter/bin/",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  },
}

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
