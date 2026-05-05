vim.g.mapleader = " "

local function map(mode, binding, action, desc, opts)
  local m, b, a, d, o
  if type(mode) == "table" then
    m = mode.mode or mode[1]
    b = mode.binding or mode[2]
    a = mode.action or mode[3]
    d = mode.desc or mode[4]
    o = mode.opts
  else
    m, b, a, d, o = mode, binding, action, desc, opts
  end
  local options = vim.tbl_extend("force", { noremap = true, silent = true, desc = d or "" }, o or {})
  vim.keymap.set(m, b, a, options)
end

map({ "n", "j", "v:count == 0 ? 'gj' : 'j'", opts = { expr = true } })
map({ "n", "k", "v:count == 0 ? 'gk' : 'k'", opts = { expr = true } })

map("n", "J", "mzJ`z")
map("n", "~", "~h")

-- Better indentation in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-b>", "<C-b>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Line movement (move lines up/down)
map("n", "<C-j>", "<cmd>move .+1<CR>==", "Move line down")
map("n", "<C-k>", "<cmd>move .-2<CR>==", "Move line up")
map("v", "<C-j>", "<cmd>move '>+1<CR>gv=gv", "Move selection down")
map("v", "<C-k>", "<cmd>move '<-2<CR>gv=gv", "Move selection up")

-- Better search (clear highlight)
map("n", "<esc>", "<cmd>nohlsearch<CR><esc>", "Clear search highlight")

-- map("n", "n", "nzzzv")
-- map("n", "N", "Nzzzv")

map("x", "p", '"_dP')

-- Replace word under cursor
map("n", "<leader>sw", [[<cmd>%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Split window
map("n", "-", "<cmd>split .<CR>", "Split horizontally")
map("n", "\\", "<cmd>vsplit .<CR>", "Split vertically")

map("n", "<A-->", function()
  vim.cmd("sp | term")
  vim.bo[vim.api.nvim_get_current_buf()].bufhidden = "wipe"
  vim.cmd.startinsert()
end)

map("n", "<A-\\>", function()
  vim.cmd("vs | term")
  vim.bo[vim.api.nvim_get_current_buf()].bufhidden = "wipe"
  vim.cmd.startinsert()
end)

-- Better command mode
map("c", "<C-h>", "<Home>")
map("c", "<C-l>", "<End>")
map("c", "<C-j>", "<Down>")
map("c", "<C-k>", "<Up>")

map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

-- Better insert mode
map("i", "<C-H>", "<C-o>db", "Delete word backward")
map("i", "<C-Del>", "<C-o>dw", "Delete word forward")

map("i", "<C-Left>", "<C-o>b", "Move one word backward")
map("i", "<C-Right>", "<C-o>w", "Move one word forward")

map("i", "<S-right>", "<C-o>vw", "Select word forward")
map("i", "<S-left>", "<C-o>vb", "Select word backward")

map("i", "<C-s>", "<cmd>w<CR>", "Save file")

map("i", "<C-f>", "<C-o>/", "Search for a string")

map("i", "<C-S-z>", "<C-o><C-r>", "Undo last move")
map("i", "<C-z>", "<C-o>u", "Undo last move")

map("i", "<C-n>", "<C-o>n", "Move to next occurrence")
map("i", "<C-p>", "<C-o>N", "Move to previous occurrence")
