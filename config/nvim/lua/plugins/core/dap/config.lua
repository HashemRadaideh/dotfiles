return function()
  local dap, dapui = require("dap"), require("dapui")

  -- vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "ErrorMsg", linehl = "", numhl = "CurSearch" })
  vim.fn.sign_define("DapBreakpoint", {
    text = "⬤",
    texthl = "DiagnosticError",
    linehl = "",
    numhl = "DiagnosticError"
  })
  vim.fn.sign_define("DapBreakpointCondition", {
    text = "◆",
    texthl = "DiagnosticWarn",
    linehl = "",
    numhl = "DiagnosticWarn"
  })
  vim.fn.sign_define("DapBreakpointRejected", {
    text = "●",
    texthl = "DiagnosticHint",
    linehl = "",
    numhl = ""
  })
  vim.fn.sign_define("DapLogPoint", {
    text = "◆",
    texthl = "DiagnosticInfo",
    linehl = "",
    numhl = ""
  })
  vim.fn.sign_define("DapStopped", {
    text = "▶",
    texthl = "DiagnosticOk",
    linehl = "DiffAdd",
    numhl = "DiagnosticOk"
  })

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
end
