vim.keymap.set({ "n", "x", "o", "v" }, "<C-z>", "<nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o", "v" }, "Q", "<nop>", { noremap = true, silent = true })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Move lines up or down https://vim.fandom.com/wiki/Moving_lines_up_or_down
-- vim.keymap.set("v", "<C-j>", "<cmd>m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
-- vim.keymap.set("v", "<C-k>", "<cmd>m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })
-- vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
-- vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Remove newline and keep cursor position
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true })

-- Leader-J/K deletes blank line below/above, and leader-j/k inserts.
vim.keymap.set("n", "<leader>j", "<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>J", "m`<cmd>silent +g/\\m^\\s*$/d<CR>``<cmd>noh<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>K", "m`<cmd>silent -g/\\m^\\s*$/d<CR>``<cmd>noh<CR>", { noremap = true, silent = true })

-- keep screen centered when moving
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Improved search
vim.keymap.set(
  { "n", "i" },
  "<Esc>",
  "<cmd>nohl<CR><esc>", -- <Esc><Plug>multi_cursor_quit_key",
  { noremap = true, silent = true, desc = "Escape and clear hlsearch" }
)

-- vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
-- vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

vim.keymap.set(
  { "n", "x", "o" },
  "n",
  "'Nn'[v:searchforward]",
  { noremap = true, silent = true, expr = true, desc = "Next search result" }
)
vim.keymap.set(
  { "n", "x", "o" },
  "N",
  "'nN'[v:searchforward]",
  { noremap = true, silent = true, expr = true, desc = "Previous search result" }
)

-- Replace with empty buffer
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- Replace word under cursor
vim.keymap.set(
  "n",
  "<leader>sw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { noremap = true, silent = true }
)

-- Improved indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- keep position after changing capitalization
vim.keymap.set("n", "~", "~h", { noremap = true, silent = true })

-- better insert mode
vim.keymap.set("i", "<C-H>", "<C-o>db", { noremap = true, silent = true, desc = "Delete word backward" })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true, silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<S-right>", "<C-o>v", { noremap = true, silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<S-left>", "<C-o>v", { noremap = true, silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- vim.keymap.set("i", "<C-Left>", "<C-o>b", { noremap = true, silent = true, desc = "Move one word forward" })
-- vim.keymap.set("i", "<C-Right>", "<C-o>w", { noremap = true, silent = true, desc = "Move one word backward" })

vim.keymap.set("i", "<C-f>", "<C-o>/", { noremap = true, silent = true, desc = "Search for a string" })

vim.keymap.set("i", "<C-n>", "<C-o>n", { noremap = true, silent = true, desc = "Move to next occurrence" })
vim.keymap.set("i", "<C-p>", "<C-o>N", { noremap = true, silent = true, desc = "Move to previous occurrence" })

vim.keymap.set("i", ",", ",<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", ".", ".<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", ";", ";<C-g>u", { noremap = true, silent = true })

vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, silent = true, desc = "Undo last move" })

vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set(
  { "n", "v", "i", "s" },
  "<C-s>",
  "<cmd>w<CR><Esc>",
  { noremap = true, silent = true, desc = "Save file" }
)

vim.keymap.set("n", "-", "<cmd>sp .<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "\\", "<cmd>vs .<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>sp", "<cmd>e /tmp/scratchpad<cr>", { noremap = true, silent = true, desc = "Scratchpad" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { noremap = true, silent = true, desc = "New File" })

-- Plugins mappings
-- Package manager mappings
vim.keymap.set("n", "<leader>mp", "<cmd>Lazy<CR>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ghc", "<cmd>Copilot<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ai", "<cmd>NeoAIToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gpt", "<cmd>ChatGPT<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", "<cmd>TabnineToggle<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<tab>", "<cmd>bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-tab>", "<cmd>bprev<CR>", { noremap = true, silent = true })

-- ToggleTerm mappings
vim.keymap.set("n", "<leader>tlg", "<cmd>lua Lazygit:toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tgl", "<cmd>lua Glow:toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>tlf",
  "<cmd>lua LF:toggle()<CR>",
  { noremap = true, silent = true, desc = "Focus Explorer" }
)
vim.keymap.set(
  "n",
  "<leader>tfm",
  "<cmd>lua Frogmouth:toggle()<CR>",
  { noremap = true, silent = true, desc = "Focus Explorer" }
)

-- Window picker
vim.keymap.set(
  "n",
  "<leader>w",
  "<cmd>lua require('window-picker').pick_window()<CR>",
  { noremap = true, silent = true }
)

-- Markdown-preview mappings
vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreviewToggle<cr>", { noremap = true, silent = true })
