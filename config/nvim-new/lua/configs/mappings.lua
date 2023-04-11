local map = function(mode, lhs, rhs, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('n', '<C-h>', '<C-w>h', { desc = "Go to left window/pane" })
map('n', '<C-j>', '<C-w>j', { desc = "Go to left window/pane" })
map('n', '<C-k>', '<C-w>k', { desc = "Go to left window/pane" })
map('n', '<C-l>', '<C-w>l', { desc = "Go to left window/pane" })

map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })
map('n', '<C-Right>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window height' })

-- Move lines up or down
map('n', '<M-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<M-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
map('i', '<M-j>', '<Esc><cmd>m .+1<CR>==gi', { desc = 'Move line down' })
map('i', '<M-k>', '<Esc><cmd>m .-2<CR>==gi', { desc = 'Move line up' })
map('v', '<M-j>', "<cmd>m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', '<M-k>', "<cmd>m '<-2<CR>gv=gv", { desc = 'Move line up' })

map("i", "<C-H>", "<C-o>db", { desc = "Delete word backward" })
map("i", "<C-Del>", "<C-o>dw", { desc = "Delete word forward" })

map("i", "<C-Left>", "<C-o>w", { desc = "Move one word forward" })
map("i", "<C-Right>", "<C-o>b", { desc = "Move one word backward" })

map("i", "<C-f>", "<C-o>/", { desc = "Move one word backward" })

map("i", "<C-n>", "<C-o>n", { desc = "Move one word backward" })
map("i", "<C-p>", "<C-o>N", { desc = "Move one word backward" })

map("n", "<leader>sp", ":e /tmp/scratchpad<cr>", { desc = "Scratchpad" })

-- map('n', '<leader>c', ':cd %/..<CR>')

-- https://superuser.com/questions/93492/how-to-add-a-command-in-vim-editor
-- vim.cmd([[command Gcc !set $1 `echo "%" | sed 's/\.c//g'` ;gcc -o $1 "%" ; chmod o+x $1; $1]])
-- vim.cmd([[command Gdb !set $1 `echo "%" | sed 's/\.c//g'` ;gcc -o $1 "%" ; gdb $1]])
-- map('n', '<F5>', ':Gdb<CR>')
-- map('n', '<C-F5>', ':Gdb<CR>')

-- vim.cmd(string.format("command Reload :wa! | :so %s", Path))
-- map('n', '<leader>r', ':Reload<CR>')

-- map('n', '<leader>y', ":enew | startinsert<CR>")
map("n", "<leader>y", ":enew<cr>", { desc = "New File" })

map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- map('n', '<tab>', ':tabn<CR>')
-- map('n', '<S-tab>', ':tabp<CR>')
map('n', '<leader>i', ':tabnew<CR>')

map('n', '~', '~h')


-- map('n', '<C-s>', '<C-w>s')
-- map('n', '<C-v>', '<C-w>v')


-- " Leader-J/K deletes blank line below/above, and leader-j/k inserts.
map('n', '<leader>J', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>')
map('n', '<leader>K', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>')
map('n', '<leader>j', ':set paste<CR>m`o<Esc>``:set nopaste<CR>')
map('n', '<leader>k', ':set paste<CR>m`O<Esc>``:set nopaste<CR>')

-- add new line from current position
-- map('n', '<leader>j', ':set paste<CR>i<CR><ESC>x:set nopaste<CR>')

map('n', '<leader>h', '_')
map('n', '<leader>l', '$')
map('n', '<leader>n', ':nohl<CR>')

-- map('n', '<F5>', ':terminal pwsh.exe<CR>')

-- function DelMark()
--   vim.cmd [[function! Delmarks()                                              ]]
--   vim.cmd [[  let l:m = join(filter(                                          ]]
--   vim.cmd [[      \ map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'), ]]
--   vim.cmd [[      \ 'line("''".v:val) == line(".")'))                         ]]
--   vim.cmd [[   if !empty(l:m)                                                 ]]
--   vim.cmd [[       exe 'delmarks' l:m                                         ]]
--   vim.cmd [[   endif                                                          ]]
--   vim.cmd [[endfunction                                                       ]]
-- end
--
-- map('n', 'dm', ':<c-u>lua Delmarks()<cr>')

-- map('i', 'jj', '<Esc>')
-- map('i', 'jk', '<Esc>')
-- map('i', 'kj', '<Esc>')
-- map('i', 'kk', '<Esc>')

-- map('i', '<C-Z>', '<Esc><C-r>i')
-- map('i', '<C-z>', '<Esc>ui')

-- map("n", "<leader>w", ":w<cr>", { desc = "Save" })
-- map("n", "<leader>q", ":q<cr>", { desc = "Quit" })
-- map("n", "<C-s>", ":w!<cr>", { desc = "Force write" })
-- map("n", "<C-q>", ":q!<cr>", { desc = "Force quit" })

-- Packer mappings
map('n', '<leader>ps', ':PackerSync<CR>')

-- Symbol-Outlines
map('n', '<C-u>', ':SymbolsOutline<CR>')

-- map("n", "<F10>", ":TransparentToggle<cr>", { desc = "Transparency toggle" })

-- Tagbar mappings
-- map('n', '<F8>', ':TagbarToggle<CR>')

-- Nvim-tree mappings
-- map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
-- map("n", "<leader>o", ":NvimTreeFocus<CR>", { desc = "Focus Explorer" })

-- Neotree mappings
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Explorer" })
-- map("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus Explorer" })
map('n', '<leader><leader>e', ':Neotree toggle buffers<CR>', { desc = "Neotree toggle buffer view" })
map('n', 'g<leader>e', ':Neotree toggle git_status<CR>', { desc = "Neotree toggle git status view" })

-- CamelCaseMotion mappings
map('n', '<C-g>', '<Plug>multi_cursor_start_word_key')
map('n', '<C-G>', '<Plug>multi_cursor_select_all_word_key')
map('n', 'g<C-g>', '<Plug>multi_cursor_start_key')
map('n', 'g<C-G>', '<Plug>multi_cursor_select_all_key')
map('n', '<C-g>', '<Plug>multi_cursor_next_key')
map('n', '<C-p>', '<Plug>multi_cursor_prev_key')
map('n', 'g<C-x>', '<Plug>multi_cursor_skip_key')
map('n', '<Esc>', '<Plug>multi_cursor_quit_key')

map('n', 'w', '<Plug>CamelCaseMotion_w')
map('n', 'b', '<Plug>CamelCaseMotion_b')
map('n', 'e', '<Plug>CamelCaseMotion_e')
map('n', 'ge', '<Plug>CamelCaseMotion_ge')
-- map('s', 'w')
-- map('s', 'b')
-- map('s', 'e')
-- map('s', 'ge')

map('o', 'iw', '<Plug>CamelCaseMotion_iw')
map('x', 'iw', '<Plug>CamelCaseMotion_iw')
map('o', 'ib', '<Plug>CamelCaseMotion_ib')
map('x', 'ib', '<Plug>CamelCaseMotion_ib')
map('o', 'ie', '<Plug>CamelCaseMotion_ie')
map('x', 'ie', '<Plug>CamelCaseMotion_ie')

map('i', '<C-Left>', '<C-o><Plug>CamelCaseMotion_b')
map('i', '<C-Right>', '<C-o><Plug>CamelCaseMotion_w')

-- Bufferline mappings
map('n', '<S-tab>', ':BufferLineCyclePrev<CR>')
map('n', '<tab>', ':BufferLineCycleNext<CR>')
-- map('n', '<C-,>', ':BufferLineCyclePrev<CR>')
-- map('n', '<C-.>', ':BufferLineCycleNext<CR>')

map('n', '<C-z>', ':BufferLineCloseLeft<CR>')
map('n', '<C-x>', ':bd %<CR>')
map('n', '<C-c>', ':BufferLineCloseRight<CR>')

map('n', '<leader>,', ':BufferLineMovePrev<CR>')
map('n', '<leader>.', ':BufferLineMoveNext<CR>')

map('n', '<leader>be', ':BufferLineSortByExtension<CR>')
map('n', '<leader>bd', ':BufferLineSortByDirectory<CR>')
map('n', '<leader>bb',
  ":lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>")

map('n', '<C-1>', ':BufferLineGoToBuffer 1<CR>')
map('n', '<C-2>', ':BufferLineGoToBuffer 2<CR>')
map('n', '<C-3>', ':BufferLineGoToBuffer 3<CR>')
map('n', '<C-4>', ':BufferLineGoToBuffer 4<CR>')
map('n', '<C-5>', ':BufferLineGoToBuffer 5<CR>')
map('n', '<C-6>', ':BufferLineGoToBuffer 6<CR>')
map('n', '<C-7>', ':BufferLineGoToBuffer 7<CR>')
map('n', '<C-8>', ':BufferLineGoToBuffer 8<CR>')
map('n', '<C-9>', ':BufferLineGoToBuffer 9<CR>')

-- lspconfig
map('n', '<leader>p', ':lua vim.diagnostic.open_float()<CR>')
map('n', 'gk', ':lua vim.diagnostic.goto_prev()<CR>')
map('n', 'gj', ':lua vim.diagnostic.goto_next()<CR>')
map('n', '<leader>q', ':lua vim.diagnostic.setloclist()<CR>')

-- lspsaga mappings
-- map("n", "gr", ":Lspsaga rename<cr>", { silent = true, noremap = true })
-- map("n", "gx", ":Lspsaga code_action<cr>", { silent = true, noremap = true })
-- map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
-- map("n", "K", ":Lspsaga hover_doc<cr>", { silent = true, noremap = true })
-- map("n", "go", ":Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
-- map("n", "gj", ":Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
-- map("n", "gk", ":Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
-- map("n", "<C-u>", ":lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
-- map("n", "<C-d>", ":lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

-- Telescope: using Lua functions
map('n', '<leader>ff', ':lua require("telescope.builtin").find_files()<cr>')
map('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fb', ':lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fh', ':lua require("telescope.builtin").help_tags()<cr>')
map('n', '<leader>fo', ':lua require("telescope.builtin").oldfiles()<cr>')

-- ToggleTasks/Telescope: Toggle Tasks/Telescope
-- vim.keymap.set('n', '<leader>ts', require('telescope').extensions.toggletasks.spawn, { desc = 'toggletasks: spawn' })

-- ToggleTerm mappings
map("n", "<leader>t", ":lua Lazygit:toggle() <CR>")
map("n", "<leader>g", ":lua Glow:toggle()<CR>")
map("n", "<leader>o", ":lua LF:toggle()<CR>", { desc = "Focus Explorer" })

-- Trouble mappings
-- map("n", "<leader>xx", ":Trouble<cr>", { silent = true, noremap = true })
-- map("n", "<leader>xw", ":Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
-- map("n", "<leader>xd", ":Trouble document_diagnostics<cr>", { silent = true, noremap = true })
-- map("n", "<leader>xl", ":Trouble loclist<cr>", { silent = true, noremap = true })
-- map("n", "<leader>xq", ":Trouble quickfix<cr>", { silent = true, noremap = true })
-- map("n", "gR", ":Trouble lsp_references<cr>", { silent = true, noremap = true })

-- jump to the next item, skipping the groups
-- map('n', 'g.', 'require("trouble").next({ skip_groups = true, jump = true })')

-- jump to the previous item, skipping the groups
-- map('n', 'g,', ':lua require("trouble").previous({ skip_groups = true, jump = true })')

map('n', '<leader>w', ":lua require('window-picker').pick_window()<CR>")

-- gitlinker mappings
map(
  'n',
  '<leader>gb',
  ':lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true }
)
map(
  'v',
  '<leader>gb',
  ':lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {}
)

map(
  'n',
  '<leader>gY',
  ':lua require"gitlinker".get_repo_url()<cr>',
  { silent = true }
)
map(
  'n',
  '<leader>gB',
  ':lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true }
)

-- Illuminate mappings
map('n', '<a-n>', ':lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
map('n', '<a-p>', ':lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', { noremap = true })

-- DAP mappings
map("n", "<F2>", ":lua require('dap').step_over()<CR>")
map("n", "<F3>", ":lua require('dap').step_into()<CR>")
map("n", "<F4>", ":lua require('dap').step_out()<CR>")
map("n", "<F5>", ":lua require('dap').continue()<CR>")

map("n", "<F6>", ":lua require('dapui').toggle()<CR>")
map('n', '<leader>;', ':lua require"dap".toggle_breakpoint()<cr>')

map("n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
map("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

map("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
map("n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

map("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
map("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

map("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>")
map("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

map("n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
map("n", "<Leader>di", ":lua require('dapui').toggle()<CR>")

-- session manager mappings
map('n', '<leader>ss', ':lua require"session_manager".load_session()<cr>')
map('n', '<leader>sd', ':lua require"session_manager".delete_session()<cr>')

-- Markdown-preview mappings
map('n', '<leader>m', ':MarkdownPreviewToggle<cr>')
