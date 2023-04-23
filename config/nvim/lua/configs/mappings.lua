vim.keymap.set({ "n", "i", "x", "o", "v" }, "<C-z>", "<nop>")
vim.keymap.set({ "n", "i", "x", "o", "v" }, "Q", "<nop>")

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- move between panes with Ctrl hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Go to left window/pane" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Go to left window/pane" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Go to left window/pane" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Go to left window/pane" })

-- resize panes with Ctrl up, down, left, right
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window height' })

-- Move lines up or down
vim.keymap.set('v', '<C-j>', "<cmd>m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', '<C-k>', "<cmd>m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Remove newline and keep cursor position
vim.keymap.set('n', 'J', "mzJ`z")

-- Leader-J/K deletes blank line below/above, and leader-j/k inserts.
vim.keymap.set('n', '<leader>j', '<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>')
vim.keymap.set('n', '<leader>J', 'm`<cmd>silent +g/\\m^\\s*$/d<CR>``<cmd>noh<CR>')
vim.keymap.set('n', '<leader>K', 'm`<cmd>silent -g/\\m^\\s*$/d<CR>``<cmd>noh<CR>')

-- keep screen centered when moving
vim.keymap.set('n', '<C-b>', '<C-b>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Improved search
vim.keymap.set({ 'n', 'i' }, '<Esc>', '<cmd>nohl<CR><Esc><Plug>multi_cursor_quit_key',
  { desc = 'Escape and clear hlsearch' })

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'x', 'o' }, 'n', "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set({ 'n', 'x', 'o' }, 'N', "'nN'[v:searchforward]", { expr = true, desc = "Previous search result" })

-- Replace with empty buffer
vim.keymap.set('x', 'p', "\"_dP")

-- Replace word under cursor
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Improved indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- keep position after changing capitalization
vim.keymap.set('n', '~', '~h')

-- better insert mode
vim.keymap.set("i", "<C-H>", "<C-o>db", { desc = "Delete word backward" })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { desc = "Delete word forward" })
vim.keymap.set("i", "<S-right>", "<C-o>v", { desc = "Delete word forward" })
vim.keymap.set("i", "<S-left>", "<C-o>v", { desc = "Delete word forward" })
vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("i", "<C-Left>", "<C-o>b", { desc = "Move one word forward" })
-- vim.keymap.set("i", "<C-Right>", "<C-o>w", { desc = "Move one word backward" })

vim.keymap.set("i", "<C-f>", "<C-o>/", { desc = "Search for a string" })

vim.keymap.set("i", "<C-n>", "<C-o>n", { desc = "Move to next occurrence" })
vim.keymap.set("i", "<C-p>", "<C-o>N", { desc = "Move to previous occurrence" })

vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = "Undo last move" })

vim.keymap.set({ 'n', 'v', 'i', 's' }, '<C-s>', '<cmd>w<CR><Esc>', { desc = 'Save file' })

vim.keymap.set("n", "<leader>sp", "<cmd>e /tmp/scratchpad<cr>", { desc = "Scratchpad" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Plugins mappings
-- Packer mappings
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy<CR>')

-- ToggleTerm mappings
vim.keymap.set("n", "<leader>tl", "<cmd>lua Lazygit:toggle()<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd>lua Glow:toggle()<CR>")
vim.keymap.set("n", "<leader>to", "<cmd>lua LF:toggle()<CR>", { desc = "Focus Explorer" })

-- Telescope: using Lua functions
vim.keymap.set('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
vim.keymap.set('n', '<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
vim.keymap.set("n", "<leader>tt", '<cmd>lua require("telescope").extensions.lazygit.lazygit()<CR>')

-- Neotree mappings
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
vim.keymap.set('n', '<leader><leader>e', '<cmd>Neotree toggle buffers<CR>', { desc = "Neotree toggle buffer view" })
vim.keymap.set('n', '<leader>ge', '<cmd>Neotree toggle git_status<CR>', { desc = "Neotree toggle git status view" })

-- Undotree mappings
vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<CR>', { desc = "Open Undotree" })

-- Symbol-Outlines
vim.keymap.set('n', '<leader>so', '<cmd>SymbolsOutline<CR>', { desc = "Open SymbolsOutline" })

-- Window picker
vim.keymap.set('n', '<leader>w', "<cmd>lua require('window-picker').pick_window()<CR>")

-- session manager mappings
vim.keymap.set('n', '<leader>ss', '<cmd>lua require"session_manager".load_session()<cr>')
vim.keymap.set('n', '<leader>sd', '<cmd>lua require"session_manager".delete_session()<cr>')

-- ZenMode
vim.keymap.set("n", "<Leader>zz", vim.cmd.ZenMode, { silent = true, desc = "Toggle ZenMode" })

-- CamelCaseMotion mappings
vim.keymap.set({ 'n', 'v' }, '<C-g>', '<Plug>multi_cursor_start_word_key')
vim.keymap.set({ 'n', 'v' }, '<C-G>', '<Plug>multi_cursor_select_all_word_key')
vim.keymap.set({ 'n', 'v' }, 'g<C-g>', '<Plug>multi_cursor_start_key')
vim.keymap.set({ 'n', 'v' }, 'g<C-G>', '<Plug>multi_cursor_select_all_key')
vim.keymap.set({ 'n', 'v' }, '<C-g>', '<Plug>multi_cursor_next_key')
vim.keymap.set({ 'n', 'v' }, '<C-p>', '<Plug>multi_cursor_prev_key')
vim.keymap.set({ 'n', 'v' }, 'g<C-x>', '<Plug>multi_cursor_skip_key')

vim.keymap.set({ 'n', 'v' }, 'w', '<Plug>CamelCaseMotion_w')
vim.keymap.set({ 'n', 'v' }, 'b', '<Plug>CamelCaseMotion_b')
vim.keymap.set({ 'n', 'v' }, 'e', '<Plug>CamelCaseMotion_e')
vim.keymap.set({ 'n', 'v' }, 'ge', '<Plug>CamelCaseMotion_ge')

vim.keymap.set({ 'o', 'x' }, 'iw', '<Plug>CamelCaseMotion_iw')
vim.keymap.set({ 'o', 'x' }, 'ib', '<Plug>CamelCaseMotion_ib')
vim.keymap.set({ 'o', 'x' }, 'ie', '<Plug>CamelCaseMotion_ie')

vim.keymap.set('i', '<C-Left>', '<C-o><Plug>CamelCaseMotion_b')
vim.keymap.set('i', '<C-Right>', '<C-o><Plug>CamelCaseMotion_w')

-- Bufferline mappings
vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<tab>', '<cmd>BufferLineCycleNext<CR>')
-- vim.keymap.set('n', '<C-,>', '<cmd>BufferLineCyclePrev<CR>')
-- vim.keymap.set('n', '<C-.>', '<cmd>BufferLineCycleNext<CR>')

vim.keymap.set('n', '<leader>z', '<cmd>BufferLineCloseLeft<CR>')
vim.keymap.set('n', '<leader>x', '<cmd>bd %<CR>')
vim.keymap.set('n', '<leader>c', '<cmd>BufferLineCloseRight<CR>')

vim.keymap.set('n', '<leader>,', '<cmd>BufferLineMovePrev<CR>')
vim.keymap.set('n', '<leader>.', '<cmd>BufferLineMoveNext<CR>')

vim.keymap.set('n', '<leader>be', '<cmd>BufferLineSortByExtension<CR>')
vim.keymap.set('n', '<leader>bd', '<cmd>BufferLineSortByDirectory<CR>')
vim.keymap.set('n', '<leader>bb',
  "<cmd>lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>")

vim.keymap.set('n', '<C-1>', '<cmd>BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<C-2>', '<cmd>BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<C-3>', '<cmd>BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', '<C-4>', '<cmd>BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', '<C-5>', '<cmd>BufferLineGoToBuffer 5<CR>')
vim.keymap.set('n', '<C-6>', '<cmd>BufferLineGoToBuffer 6<CR>')
vim.keymap.set('n', '<C-7>', '<cmd>BufferLineGoToBuffer 7<CR>')
vim.keymap.set('n', '<C-8>', '<cmd>BufferLineGoToBuffer 8<CR>')
vim.keymap.set('n', '<C-9>', '<cmd>BufferLineGoToBuffer 9<CR>')

-- lspconfig
vim.keymap.set('n', '<leader>pd', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'gk', ':lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', 'gj', ':lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>q', ':lua vim.diagnostic.setloclist()<CR>')

-- DAP mappings
vim.keymap.set("n", "<F2>", "<cmd>lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F3>", "<cmd>lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F4>", "<cmd>lua require('dap').step_out()<CR>")
vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<CR>")

vim.keymap.set("n", "<F6>", "<cmd>lua require('dapui').toggle()<CR>")
vim.keymap.set('n', '<leader>;', '<cmd>lua require"dap".toggle_breakpoint()<cr>')

vim.keymap.set("n", "<Leader>dhh", "<cmd>lua require('dap.ui.variables').hover()<CR>")
vim.keymap.set("v", "<Leader>dhv", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>")

vim.keymap.set("n", "<Leader>duh", "<cmd>lua require('dap.ui.widgets').hover()<CR>")
vim.keymap.set("n", "<Leader>duf",
  "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

vim.keymap.set("n", "<Leader>dro", "<cmd>lua require('dap').repl.open()<CR>")
vim.keymap.set("n", "<Leader>drl", "<cmd>lua require('dap').repl.run_last()<CR>")

vim.keymap.set("n", "<Leader>dbc",
  "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition<cmd> '))<CR>")
vim.keymap.set("n", "<Leader>dbm",
  "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message<cmd> ') })<CR>")
vim.keymap.set("n", "<Leader>dbt", "<cmd>lua require('dap').toggle_breakpoint()<CR>")

vim.keymap.set("n", "<Leader>dc", "<cmd>lua require('dap.ui.variables').scopes()<CR>")
vim.keymap.set("n", "<Leader>di", "<cmd>lua require('dapui').toggle()<CR>")

-- Markdown-preview mappings
vim.keymap.set('n', '<leader>m', '<cmd>MarkdownPreviewToggle<cr>')
