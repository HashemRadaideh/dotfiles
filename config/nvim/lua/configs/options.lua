Homedir = os.getenv("HOME")
Sessiondir = vim.fn.stdpath("data") .. "/sessions"

vim.cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

local settings = {
  g = {
    mapleader = " ",
    maplocalleader = " ",
    -- 	do_filetype_lua = 1,
    -- 	-- did_load_filetypes = 0,
    -- 	highlighturl_enabled = true,
    -- 	zipPlugin = false,
    -- 	markdown_recommended_style = 0,
  },
  opt = {
    number = true,
    relativenumber = true,
    mouse = "a",
    clipboard = "unnamedplus",
    -- 	-- scrolloff = 10,
    -- 	-- sidescrolloff = 10,
    -- 	-- numberwidth = 2,
    -- 	-- signcolumn = "yes:2",
    -- 	-- colorcolumn = "80,120",
    -- showtabline = 2,
    cursorline = true,
    cursorcolumn = true,
    cursorlineopt = { "screenline", "number" },
    ignorecase = true,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    hlsearch = true,
    incsearch = true,
    inccommand = "nosplit",
    -- 	wrap = true,
    -- 	wrapmargin = 1,
    expandtab = false, -- Use spaces instead of tabs
    softtabstop = 2, -- Number of spaces tabs count for
    tabstop = 2, -- Number of spaces in a tab
    shiftwidth = 2, -- Size of an indent
    shiftround = true,
    autoindent = true,
    smartindent = true, -- Insert indents automatically
    preserveindent = true,
    copyindent = true,
    breakindent = true,
    smarttab = true,
    autowrite = true,
    confirm = true,
    timeout = true,
    timeoutlen = 300,
    foldenable = true,
    foldlevel = 99,
    foldlevelstart = 99,
    foldcolumn = "0",
    -- foldmethod = "expr",
    -- foldexpr = "nvim_treesitter#foldexpr()",
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
    undofile = true,
    undolevels = 10000,
    undodir = vim.fn.stdpath("data") .. "/undos",
    -- 	backspace = { "indent", "eol", "start" },
    -- 	formatoptions = "jcroqlnt", -- tcqj
    -- 	grepformat = "%f:%l:%c:%m",
    -- 	grepprg = "rg --vimgrep",
    -- 	laststatus = 0,
    -- 	list = true,
    -- 	spelllang = { "en" },
    termguicolors = true,
    -- winminwidth = 5,
    fillchars = {
      fold = "•",
      eob = " ",
      horiz = "━",
      horizup = "┻",
      horizdown = "┳",
      vert = "┃",
      vertleft = "┫",
      vertright = "┣",
      verthoriz = "╋",
    },
    -- 	history = 500,
    -- 	wildmode = "list:longest:full,full", -- Command-line completion mode
    -- 	wildignore = { "*/.git/*", "*/node_modules/*" }, -- Ignore these files/folders
    completeopt = { "menu", "menuone", "noinsert", "noselect" },
    -- 	-- completeopt-=preview,
    -- 	hidden = true,
    -- 	exrc = true,
    swapfile = false,
    shortmess = {
      A = true, -- ignore annoying swap file messages
      c = true, -- Do not show completion messages in command line
      F = true, -- Do not show file info when editing a file, in the command line
      I = true, -- Do not show the intro message
      W = true, -- Do not show "written" in command line when writing
    },
    updatetime = 200, -- If in this many milliseconds nothing is typed, the swap file will be written to disk. Also used for CursorHold autocommand
    directory = vim.fn.stdpath("data") .. "/swaps",
    -- 	backup = false,
    -- 	writebackup = false,
    -- 	backupdir = vim.fn.stdpath("data") .. "/backups",
    -- 	showmode = false,
    -- 	showmatch = true,
    -- 	-- showcmd = true,
    -- 	fileencoding = "utf-8",
    -- 	-- autochdir = true,
    -- 	pumblend = 10,
    -- 	pumheight = 10,
    -- 	cmdheight = 1,
    -- 	conceallevel = 3,
    -- 	shada = "!,'0,f0,<50,s10,h",
    -- 	-- shell = "/bin/zsh",
  },
}

for mode, options in pairs(settings) do
  for option, value in pairs(options) do
    vim[mode][option] = value
  end
end

local disabled_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
