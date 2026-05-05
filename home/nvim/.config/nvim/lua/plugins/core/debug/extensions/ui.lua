return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  keys = {
    {
      "<Leader>du",
      function()
        require("dapui").toggle()
      end,
    },
  },
  opts = {
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 40,
        position = "left",
      },
      {
        elements = { "repl", "console", { id = "disassembly" } },
        position = "bottom",
        size = 10,
      },
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.before.attach.dapui_config = function(_session, _body)
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function(_session, _body)
      dapui.open()
    end

    -- dap.listeners.before.event_terminated.dapui_config = function(_session, _body)
    --   -- vim.notify("DAP terminated: " .. vim.inspect(body), vim.log.levels.WARN)
    -- end

    -- dap.listeners.before.event_exited.dapui_config = function(_session, _body)
    --   -- vim.notify("DAP terminated: " .. vim.inspect(body), vim.log.levels.WARN)
    -- end

    -- vim.api.nvim_create_autocmd("ExitPre", {
    --   pattern = "*",
    --   group = vim.api.nvim_create_augroup("DapUiOnVimExit", { clear = true }),
    --   once = true,
    --   callback = function(_)
    --     dapui.close()
    --   end,
    -- })
  end,
}
