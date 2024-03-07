vim.keymap.set({ "n", "x", "o", "v" }, "<C-z>", "<nop>", { noremap = true, silent = true, })
vim.keymap.set({ "n", "x", "o", "v" }, "Q", "<nop>", { noremap = true, silent = true, })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- move between panes with Ctrl hjkl
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = "Go to left window/pane" })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = "Go to left window/pane" })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = "Go to left window/pane" })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = "Go to left window/pane" })
vim.keymap.set('n', '<M-h>', [[<cmd>lua require("tmux").move_left()<cr>]],
  { noremap = true, silent = true, desc = "Go to left window/pane" })
vim.keymap.set('n', '<M-j>', [[<cmd>lua require("tmux").move_bottom()<cr>]],
  { noremap = true, silent = true, desc = "Go to left window/pane" })
vim.keymap.set('n', '<M-k>', [[<cmd>lua require("tmux").move_top()<cr>]],
  { noremap = true, silent = true, desc = "Go to left window/pane" })
vim.keymap.set('n', '<M-l>', [[<cmd>lua require("tmux").move_right()<cr>]],
  { noremap = true, silent = true, desc = "Go to left window/pane" })

-- vim.keymap.set('n', '<C-S-h>', '<cmd>vertical resize -1<cr>', { noremap = true, silent = true, desc = "Resize pane" })
-- -- vim.keymap.set('n', '<S-NL>', '<C-w>-', { noremap = true, silent = true, desc = "Resize pane" })
-- vim.keymap.set('n', '<C-S-j>', '<cmd>resize -1<cr>', { noremap = true, silent = true, desc = "Resize pane" })
-- vim.keymap.set('n', '<C-S-k>', '<cmd>resize +1<cr>', { noremap = true, silent = true, desc = "Resize pane" })
-- vim.keymap.set('n', '<C-S-l>', '<cmd>vertical resize +1<cr>', { noremap = true, silent = true, desc = "Resize pane" })
vim.keymap.set('n', '<M-S-h>', [[<cmd>lua require("tmux").resize_left()<cr>]],
  { noremap = true, silent = true, desc = 'Increase window height' })
vim.keymap.set('n', '<M-S-j>', [[<cmd>lua require("tmux").resize_bottom()<cr>]],
  { noremap = true, silent = true, desc = 'Decrease window height' })
vim.keymap.set('n', '<M-S-k>', [[<cmd>lua require("tmux").resize_top()<cr>]],
  { noremap = true, silent = true, desc = 'Increase window width' })
vim.keymap.set('n', '<M-S-l>', [[<cmd>lua require("tmux").resize_right()<cr>]],
  { noremap = true, silent = true, desc = 'Decrease window height' })

-- resize panes with Ctrl up, down, left, right
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { noremap = true, silent = true, desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { noremap = true, silent = true, desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize +2<CR>',
  { noremap = true, silent = true, desc = 'Increase window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize -2<CR>',
  { noremap = true, silent = true, desc = 'Decrease window height' })

-- Move lines up or down
vim.keymap.set('v', '<C-j>', "<cmd>m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move line down' })
vim.keymap.set('v', '<C-k>', "<cmd>m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move line up' })

-- Remove newline and keep cursor position
vim.keymap.set('n', 'J', "mzJ`z", { noremap = true, silent = true, })

-- Leader-J/K deletes blank line below/above, and leader-j/k inserts.
vim.keymap.set('n', '<leader>j', '<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>k', '<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>J', 'm`<cmd>silent +g/\\m^\\s*$/d<CR>``<cmd>noh<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>K', 'm`<cmd>silent -g/\\m^\\s*$/d<CR>``<cmd>noh<CR>', { noremap = true, silent = true, })

-- keep screen centered when moving
vim.keymap.set('n', '<C-b>', '<C-b>zz', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true, })

-- Improved search
vim.keymap.set({ 'n', 'i' }, '<Esc>', '<cmd>nohl<CR><Esc><Plug>multi_cursor_quit_key',
  { noremap = true, silent = true, desc = 'Escape and clear hlsearch' })

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true, })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true, })

vim.keymap.set({ 'n', 'x', 'o' }, 'n', "'Nn'[v:searchforward]",
  { noremap = true, silent = true, expr = true, desc = "Next search result" })
vim.keymap.set({ 'n', 'x', 'o' }, 'N', "'nN'[v:searchforward]",
  { noremap = true, silent = true, expr = true, desc = "Previous search result" })

-- Replace with empty buffer
vim.keymap.set('x', 'p', "\"_dP", { noremap = true, silent = true, })

-- Replace word under cursor
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { noremap = true, silent = true, })

-- Improved indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, })

-- keep position after changing capitalization
vim.keymap.set('n', '~', '~h', { noremap = true, silent = true, })

-- better insert mode
vim.keymap.set("i", "<C-H>", "<C-o>db", { noremap = true, silent = true, desc = "Delete word backward" })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true, silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<S-right>", "<C-o>v", { noremap = true, silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<S-left>", "<C-o>v", { noremap = true, silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true, })

-- vim.keymap.set("i", "<C-Left>", "<C-o>b", { noremap = true, silent = true, desc = "Move one word forward" })
-- vim.keymap.set("i", "<C-Right>", "<C-o>w", { noremap = true, silent = true, desc = "Move one word backward" })

vim.keymap.set("i", "<C-f>", "<C-o>/", { noremap = true, silent = true, desc = "Search for a string" })

vim.keymap.set("i", "<C-n>", "<C-o>n", { noremap = true, silent = true, desc = "Move to next occurrence" })
vim.keymap.set("i", "<C-p>", "<C-o>N", { noremap = true, silent = true, desc = "Move to previous occurrence" })

vim.keymap.set('i', ',', ',<C-g>u', { noremap = true, silent = true, })
vim.keymap.set('i', '.', '.<C-g>u', { noremap = true, silent = true, })
vim.keymap.set('i', ';', ';<C-g>u', { noremap = true, silent = true, })

vim.keymap.set('i', '<C-z>', '<C-o>u', { noremap = true, silent = true, desc = "Undo last move" })

vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set({ 'n', 'v', 'i', 's' }, '<C-s>', '<cmd>w<CR><Esc>', { noremap = true, silent = true, desc = 'Save file' })

vim.keymap.set('n', '-', '<cmd>sp .<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '\\', '<cmd>vs .<CR>', { noremap = true, silent = true, })

vim.keymap.set("n", "<leader>sp", "<cmd>e /tmp/scratchpad<cr>", { noremap = true, silent = true, desc = "Scratchpad" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { noremap = true, silent = true, desc = "New File" })

-- Plugins mappings
-- Package manager mappings
vim.keymap.set('n', '<leader>pm', '<cmd>Lazy<CR>', { noremap = true, silent = true, })

vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>', { noremap = true, silent = true, })
vim.keymap.set("n", '<leader>ghc', "<cmd>Copilot<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", '<leader>ai', "<cmd>NeoAIToggle<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", '<leader>gpt', "<cmd>ChatGPT<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", '<leader>tn', "<cmd>TabnineToggle<CR>", { noremap = true, silent = true, })

-- ToggleTerm mappings
vim.keymap.set("n", "<leader>tlg", "<cmd>lua Lazygit:toggle()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<leader>tgl", "<cmd>lua Glow:toggle()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<leader>tlf", "<cmd>lua LF:toggle()<CR>", { noremap = true, silent = true, desc = "Focus Explorer" })
vim.keymap.set("n", "<leader>tfm", "<cmd>lua Frogmouth:toggle()<CR>",
  { noremap = true, silent = true, desc = "Focus Explorer" })

-- Telescope: using Lua functions
vim.keymap.set('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>',
  { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>',
  { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>',
  { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>gf', '<cmd>lua require("telescope.builtin").git_files()<cr>',
  { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>',
  { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>',
  { noremap = true, silent = true, })
vim.keymap.set("n", "<leader>tt", '<cmd>lua require("telescope").extensions.lazygit.lazygit()<CR>',
  { noremap = true, silent = true, })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true, silent = true, })

-- Neotree mappings
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle Explorer" })
vim.keymap.set('n', '<leader><leader>e', '<cmd>Neotree toggle buffers<CR>',
  { noremap = true, silent = true, desc = "Neotree toggle buffer view" })
vim.keymap.set('n', '<leader>ge', '<cmd>Neotree toggle git_status<CR>',
  { noremap = true, silent = true, desc = "Neotree toggle git status view" })

-- Undotree mappings
vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<CR>', { noremap = true, silent = true, desc = "Open Undotree" })

-- Symbol-Outlines
vim.keymap.set('n', '<leader>so', '<cmd>SymbolsOutline<CR>',
  { noremap = true, silent = true, desc = "Open SymbolsOutline" })

-- Window picker
vim.keymap.set('n', '<leader>w', "<cmd>lua require('window-picker').pick_window()<CR>",
  { noremap = true, silent = true, })

-- session manager mappings
-- vim.keymap.set('n', '<leader>ss', '<cmd>lua require"session_manager".load_session()<cr>, { noremap = true, silent = true, }')
-- vim.keymap.set('n', '<leader>sd', '<cmd>lua require"session_manager".delete_session()<cr>', { noremap = true, silent = true, })

vim.keymap.set("n", "<leader>ss", "<cmd>lua require('auto-session.session-lens').search_session()<CR>",
  { noremap = true, silent = true, desc = "Select a session" })
vim.keymap.set("n", "<leader>sd", "<cmd>Autosession delete<CR>",
  { noremap = true, silent = true, desc = "Detele a session" })

-- ZenMode
vim.keymap.set("n", "<Leader>zz", vim.cmd.ZenMode, { silent = true, desc = "Toggle ZenMode" })

-- CamelCaseMotion mappings
vim.keymap.set({ 'n', 'v' }, '<C-g>', '<Plug>multi_cursor_start_word_key', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, '<C-G>', '<Plug>multi_cursor_select_all_word_key', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, 'g<C-g>', '<Plug>multi_cursor_start_key', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, 'g<C-G>', '<Plug>multi_cursor_select_all_key', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, '<C-g>', '<Plug>multi_cursor_next_key', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, '<C-p>', '<Plug>multi_cursor_prev_key', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, 'g<C-x>', '<Plug>multi_cursor_skip_key', { noremap = true, silent = true, })

vim.keymap.set({ 'n', 'v' }, 'w', '<Plug>CamelCaseMotion_w', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, 'b', '<Plug>CamelCaseMotion_b', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, 'e', '<Plug>CamelCaseMotion_e', { noremap = true, silent = true, })
vim.keymap.set({ 'n', 'v' }, 'ge', '<Plug>CamelCaseMotion_ge', { noremap = true, silent = true, })

vim.keymap.set({ 'o', 'x' }, 'iw', '<Plug>CamelCaseMotion_iw', { noremap = true, silent = true, })
vim.keymap.set({ 'o', 'x' }, 'ib', '<Plug>CamelCaseMotion_ib', { noremap = true, silent = true, })
vim.keymap.set({ 'o', 'x' }, 'ie', '<Plug>CamelCaseMotion_ie', { noremap = true, silent = true, })

vim.keymap.set('i', '<C-Left>', '<C-o><Plug>CamelCaseMotion_b', { noremap = true, silent = true, })
vim.keymap.set('i', '<C-Right>', '<C-o><Plug>CamelCaseMotion_w', { noremap = true, silent = true, })

-- Bufferline mappings
vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, })
-- vim.keymap.set('n', '<C-,>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, })
-- vim.keymap.set('n', '<C-.>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, })

vim.keymap.set('n', '<leader>z', '<cmd>BufferLineCloseLeft<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>x', '<cmd>bd %<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>c', '<cmd>BufferLineCloseRight<CR>', { noremap = true, silent = true, })

vim.keymap.set('n', '<S-h>', '<cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<S-l>', '<cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true, })

vim.keymap.set('n', '<leader>be', '<cmd>BufferLineSortByExtension<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>bd', '<cmd>BufferLineSortByDirectory<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>bb',
  "<cmd>lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>",
  { noremap = true, silent = true, })

vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end,
  { noremap = true, silent = true, desc = "Next todo comment" })

vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end,
  { noremap = true, silent = true, desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function() require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } }) end,
  { noremap = true, silent = true, desc = "Next error/warning todo comment" })

vim.keymap.set('n', '<C-1>', '<cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-2>', '<cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-3>', '<cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-4>', '<cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-5>', '<cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-6>', '<cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-7>', '<cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-8>', '<cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '<C-9>', '<cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true, })

-- DAP mappings
vim.keymap.set("n", "<F5>", "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true, })
vim.keymap.set('n', '<leader>;', '<cmd>lua require"dap".toggle_breakpoint()<cr>', { noremap = true, silent = true, })

vim.keymap.set("n", "<F1>", "<cmd>lua require('dap').step_over()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<F2>", "<cmd>lua require('dap').step_into()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<F3>", "<cmd>lua require('dap').step_out()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<F4>", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true, })

vim.keymap.set("n", "<Leader>dhh", "<cmd>lua require('dap.ui.variables').hover()<CR>", { noremap = true, silent = true, })
vim.keymap.set("v", "<Leader>dhv", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>",
  { noremap = true, silent = true, })

vim.keymap.set("n", "<Leader>duh", "<cmd>lua require('dap.ui.widgets').hover()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<Leader>duf",
  "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
  { noremap = true, silent = true, })

vim.keymap.set("n", "<Leader>dro", "<cmd>lua require('dap').repl.open()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<Leader>drl", "<cmd>lua require('dap').repl.run_last()<CR>", { noremap = true, silent = true, })

vim.keymap.set("n", "<Leader>dbc",
  "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition<cmd> '))<CR>",
  { noremap = true, silent = true, })
vim.keymap.set("n", "<Leader>dbm",
  "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message<cmd> ') })<CR>",
  { noremap = true, silent = true, })
vim.keymap.set("n", "<Leader>dbt", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true, })

vim.keymap.set("n", "<Leader>dc", "<cmd>lua require('dap.ui.variables').scopes()<CR>", { noremap = true, silent = true, })
vim.keymap.set("n", "<Leader>di", "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true, })

-- Markdown-preview mappings
vim.keymap.set('n', '<leader>m', '<cmd>MarkdownPreviewToggle<cr>', { noremap = true, silent = true, })
