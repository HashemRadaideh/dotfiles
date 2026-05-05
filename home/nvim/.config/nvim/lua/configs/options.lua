vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true
-- vim.opt.scrolloff = 8
-- vim.opt.sidescrolloff = 8

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- vim.opt.inccommand = "split"

vim.opt.laststatus = 3

vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 100

vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.preserveindent = true
vim.opt.copyindent = true

vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "
vim.opt.textwidth = 120

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backups"

vim.opt.swapfile = false
vim.opt.directory = vim.fn.stdpath("data") .. "/swaps"

vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = vim.fn.stdpath("data") .. "/undos"

vim.opt.whichwrap = "bs<>[]hl"
vim.opt.virtualedit = "block"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = "longest:full,full"

vim.opt.formatoptions:remove({ "t" })
vim.opt.joinspaces = false

vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

-- vim.opt.sessionoptions =
-- 	{ "buffers", "curdir", "globals", "help", "marks", "tabpages", "terminal", "winpos", "winsize" }

vim.opt.diffopt = { "internal", "filler", "closeoff", "algorithm:patience" }

vim.opt.jumpoptions = "stack"

vim.opt.ttyfast = true