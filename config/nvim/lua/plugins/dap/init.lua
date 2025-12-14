return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", opts = {}, dependencies = { "nvim-neotest/nvim-nio" } },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      require("plugins.dap.mason"),
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

      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "ErrorMsg", linehl = "", numhl = "CurSearch" })

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

      dap.configurations.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = "launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspacefolder}",
          stoponentry = false,
        },
      }

      -- dap.adapters.python = {
      --   type = "executable",
      --   command = function()
      --     if vim.env.VIRTUAL_ENV then
      --       return vim.env.VIRTUAL_ENV .. "/bin/python"
      --     elseif vim.env.CONDA_PREFIX then
      --       return vim.env.CONDA_PREFIX .. "/bin/python"
      --     end

      --     return vim.fn.exepath("python")
      --   end,
      --   args = { "-m", "debugpy.adapter" },
      -- }

      -- dap.configurations.python = {
      --   {
      --     type = "python",
      --     request = "launch",
      --     name = "Launch current file",
      --     program = "${file}",
      --     cwd = "${workspaceFolder}",
      --     console = "integratedTerminal",
      --     justMyCode = true,
      --   },
      -- }
    end,
  },
}
