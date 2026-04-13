return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui",            opts = {}, dependencies = { "nvim-neotest/nvim-nio" } },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
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
        "<Leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        { desc = "Toggle breakpoint" },
      },
      {
        "<Leader>lp",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
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
          local widgets = require("dap.ui.widgets")
          widgets.hover()
        end,
        mode = { "n", "v" },
      },
      {
        "<Leader>dp",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.preview()
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
    },
    config = require("plugins.core.dap.config"),
  },
}
