local ok, dap = pcall(require, "dap")
if not ok then
  return
end

---@diagnostic disable-next-line: redefined-local
local ok, mason = pcall(require, 'mason-nvim-dap')
if not ok then
  return
end

mason.setup {
  -- Makes a best effort to setup the various debuggers with
  -- reasonable debug configurations
  automatic_setup = true,

  -- You can provide additional configuration to the handlers,
  -- see mason-nvim-dap README for more information
  handlers = {},

  -- You'll need to check that you have the required things installed
  -- online, please don't ask me how to install them :)
  ensure_installed = {
    -- Update this to ensure that you have the debuggers for the langs you want
    -- 'delve',
  },
}

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
---@diagnostic disable-next-line: redefined-local
local ok, dapui = pcall(require, "dapui")
if not ok then
  return
end

dapui.setup({
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
    },
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  -- expand_lines = vim.fn.has("nvim-0.7"),
  -- sidebar = {
  --     -- You can change the order of elements in the sidebar
  --     elements = {
  --         -- Provide as ID strings or tables with "id" and "size" keys
  --         {
  --             id = "scopes",
  --             size = 0.25, -- Can be float or integer > 1
  --         },
  --         { id = "breakpoints", size = 0.25 },
  --         { id = "stacks", size = 0.25 },
  --         { id = "watches", size = 00.25 },
  --     },
  --     size = 40,
  --     position = "left", -- Can be "left", "right", "top", "bottom"
  -- },
  -- tray = {
  --     elements = { "repl" },
  --     size = 10,
  --     position = "bottom", -- Can be "left", "right", "top", "bottom"
  -- },
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

---@diagnostic disable-next-line: redefined-local
local ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
if not ok then
  return
end

virtual_text.setup {
  enabled = true,                        -- enable this plugin (the default)
  enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,               -- show stop reason when stopped for exceptions
  commented = false,                     -- prefix virtual text with comment string
  only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
  all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = "eol",                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

-- -- Basic debugging keymaps, feel free to change to your liking!
-- vim.keymap.set('n', '<F5>', dap.continue)
-- vim.keymap.set('n', '<F1>', dap.step_into)
-- vim.keymap.set('n', '<F2>', dap.step_over)
-- vim.keymap.set('n', '<F3>', dap.step_out)
-- vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
-- vim.keymap.set('n', '<leader>B', function()
--   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
-- end)

vim.fn.sign_define('DapBreakpoint', {
  text = '🔴',
  texthl = 'DapBreakpoint',
  linhl = 'DapBreakpoint',
  numhl = 'DapBreakpoint'
})

-- vim.fn.sign_define('DapBreakpointCondition', {
--   text = '',
--   texthl = 'DapBreakpoint',
--   linhl = 'DapBreakpoint',
--   numhl = 'DapBreakpoint'
-- })

-- vim.fn.sign_define('DapBreakpointRejected', {
--   text = '',
--   texthl = 'DapBreakpoint',
--   linhl = 'DapBreakpoint',
--   numhl = 'DapBreakpoint'
-- })

-- vim.fn.sign_define('DapLogPoint', {
--   text = '💬',
--   texthl = 'DapLogPoint',
--   linhl = 'DapLogPoint',
--   numhl = 'DapLogPoint'
-- })

-- vim.fn.sign_define('DapStopped', {
--   text = '',
--   texthl = 'DapStopped',
--   linhl = 'DapStopped',
--   numhl = 'DapStopped'
-- })

-- Install golang specific config
require('dap-go').setup()
