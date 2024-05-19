return {
  {
    { require("plugins.dap.mason-dap") },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
        { "Pocco81/dap-buddy.nvim" },
      },
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
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
        "<Leader>df",
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
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

      -- -- DAP mappings
      -- vim.keymap.set("n", "<F5>", "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })
      -- vim.keymap.set(
      --   "n",
      --   "<leader>;",
      --   '<cmd>lua require"dap".toggle_breakpoint()<cr>',
      --   { noremap = true, silent = true }
      -- )

      -- vim.keymap.set("n", "<F1>", "<cmd>lua require('dap').step_over()<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<F2>", "<cmd>lua require('dap').step_into()<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<F3>", "<cmd>lua require('dap').step_out()<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<F4>", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true })

      -- vim.keymap.set(
      --   "n",
      --   "<Leader>dhh",
      --   "<cmd>lua require('dap.ui.variables').hover()<CR>",
      --   { noremap = true, silent = true }
      -- )
      -- vim.keymap.set(
      --   "v",
      --   "<Leader>dhv",
      --   "<cmd>lua require('dap.ui.variables').visual_hover()<CR>",
      --   { noremap = true, silent = true }
      -- )

      -- vim.keymap.set(
      --   "n",
      --   "<Leader>duh",
      --   "<cmd>lua require('dap.ui.widgets').hover()<CR>",
      --   { noremap = true, silent = true }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<Leader>duf",
      --   "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
      --   { noremap = true, silent = true }
      -- )

      -- vim.keymap.set("n", "<Leader>dro", "<cmd>lua require('dap').repl.open()<CR>", { noremap = true, silent = true })
      -- vim.keymap.set(
      --   "n",
      --   "<Leader>drl",
      --   "<cmd>lua require('dap').repl.run_last()<CR>",
      --   { noremap = true, silent = true }
      -- )

      -- vim.keymap.set(
      --   "n",
      --   "<Leader>dbc",
      --   "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition<cmd> '))<CR>",
      --   { noremap = true, silent = true }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<Leader>dbm",
      --   "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message<cmd> ') })<CR>",
      --   { noremap = true, silent = true }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<Leader>dbt",
      --   "<cmd>lua require('dap').toggle_breakpoint()<CR>",
      --   { noremap = true, silent = true }
      -- )

      -- vim.keymap.set(
      --   "n",
      --   "<Leader>dc",
      --   "<cmd>lua require('dap.ui.variables').scopes()<CR>",
      --   { noremap = true, silent = true }
      -- )
      -- vim.keymap.set("n", "<Leader>di", "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })
    end,
  },
}
