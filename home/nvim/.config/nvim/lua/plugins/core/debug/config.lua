return function()
  vim.fn.sign_define("DapBreakpoint", {
    text = "⬤",
    texthl = "DiagnosticError",
    linehl = "",
    numhl = "DiagnosticError",
  })

  vim.fn.sign_define("DapBreakpointCondition", {
    text = "◆",
    texthl = "DiagnosticWarn",
    linehl = "",
    numhl = "DiagnosticWarn",
  })

  vim.fn.sign_define("DapBreakpointRejected", {
    text = "🛑",
    texthl = "DiagnosticHint",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapLogPoint", {
    text = "◆",
    texthl = "DiagnosticInfo",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapStopped", {
    text = "▶",
    texthl = "DiagnosticOk",
    linehl = "DiffAdd",
    numhl = "DiagnosticOk",
  })
end