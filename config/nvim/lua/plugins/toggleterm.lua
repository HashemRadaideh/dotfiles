local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

toggleterm.setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = { "none", "fzf" },
  autochdir = false,   -- when neovim changes it current directory the terminal will change it's own when next it's opened
  highlights = {
    -- highlights which map to a highlight group name and a table of it's values
    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    -- Normal = {
    --   guibg = "<VALUE-HERE>",
    -- },
    NormalFloat = {
      link = 'Normal'
    },
    -- FloatBorder = {
    --   guifg = "<VALUE-HERE>",
    --   guibg = "<VALUE-HERE>",
    -- },
  },
  shade_terminals = false,
  -- shading_factor = "<number>", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true,   -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
  direction = "horizontal",
  close_on_exit = true,     -- close the terminal window when the process exits
  shell = vim.o.shell,
  auto_scroll = true,       -- automatically scroll to the bottom on terminal output
  -- This field is only relevant if direction is set to "float"
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved',
    -- like `size`, width and height can be a number or function which is passed the current terminal
    -- width = <value>,
    -- height = <value>,
    winblend = 3,
    -- zindex = <value>,
  },
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
Lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
Glow = Terminal:new({ cmd = "glow", hidden = true, direction = "float" })
LF = Terminal:new({ cmd = "lf", hidden = true, direction = "float" })
Frogmouth = Terminal:new({ cmd = "frogmouth", hidden = true, direction = "float" })
