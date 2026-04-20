return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F1>",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<F2>",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<F4>",
        function()
          require("dap").step_back()
        end,
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
      },
      {
        "<F6>",
        function()
          require("dap").restart()
        end,
      },
      {
        "<F7>",
        function()
          require("dap").terminate()
        end,
      },
      {
        "<Leader>dr",
        function()
          require("dap").repl.open()
        end,
      },
      {
        "<Leader>dl",
        function()
          require("dap").run_last()
        end,
      },
      {
        "<Leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        mode = { "n", "v" },
      },
      {
        "<Leader>dp",
        function()
          require("dap.ui.widgets").preview()
        end,
        mode = { "n", "v" },
      },
      {
        "<Leader>dt",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.frames)
        end,
      },
      {
        "<Leader>ds",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes)
        end,
      },
      {
        "<Leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<Leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Conditional point message: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<Leader>lp",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
      },
      {
        "<leader>dc",
        function()
          require("dap").clear_breakpoints()
        end,
      },
    },
    config = require("plugins.core.debugger.config"),
  },
  -- require("plugins.core.debugger.extensions.persistent-breakpoints"),
  -- require("plugins.core.debugger.extensions.ui"),
  require("plugins.core.debugger.extensions.view"),
  require("plugins.core.debugger.extensions.virtual-text"),
  require("plugins.core.debugger.extensions.repl-highlight"),
  require("plugins.core.debugger.extensions.disasm"),
}
