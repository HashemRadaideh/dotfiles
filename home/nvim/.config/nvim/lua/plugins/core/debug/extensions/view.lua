return {
  "igorlfs/nvim-dap-view",
  version = "1.*",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  keys = {
    {
      "<Leader>du",
      function()
        vim.cmd([[DapViewToggle]])
      end,
    },
  },
  opts = {
    winbar = {
      show = true,
      sections = {
        "console",
        "scopes",
        "watches",
        "exceptions",
        "breakpoints",
        "threads",
        "repl",
        "disassembly",
      },
      default_section = "console",
      base_sections = {
        breakpoints = { label = "Breakpoints", keymap = "B" },
        scopes = { label = "Scopes", keymap = "S" },
        exceptions = { label = "Exceptions", keymap = "E" },
        watches = { label = "Watches", keymap = "W" },
        threads = { label = "Threads", keymap = "T" },
        repl = { label = "REPL", keymap = "R" },
        sessions = { label = "Sessions", keymap = "K" },
        console = { label = "Console", keymap = "C" },
      },
      controls = {
        enabled = true,
        position = "right",
        buttons = {
          "play",
          "step_into",
          "step_over",
          "step_out",
          "step_back",
          "run_last",
          "terminate",
          "disconnect",
        },
      },
    },
    icons = {
      collapsed = "󰅂 ",
      disabled = "",
      disconnect = "",
      enabled = "",
      expanded = "󰅀 ",
      filter = "󰈲",
      negate = " ",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = "",
    },
    virtual_text = {
      enabled = true,
      format = function(variable, _, _)
        return " " .. variable.value:gsub("%s+", " ")
      end,
    },
  },
  config = function(_, opts)
    require("dap-view").setup(opts)

    local dap = require("dap")
    local open = function()
      require("dap-view.actions").open()
    end

    dap.listeners.before.attach["jap-view-autoopen"] = open
    dap.listeners.before.launch["dap-view-autoopen"] = open

    vim.api.nvim_create_autocmd("ExitPre", {
      pattern = "*",
      group = vim.api.nvim_create_augroup("DapViewOnVimExit", { clear = true }),
      once = true,
      callback = function(_)
        require("dap-view.actions").close()
      end,
    })
  end,
}