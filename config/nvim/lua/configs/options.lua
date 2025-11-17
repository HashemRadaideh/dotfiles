vim.cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

local settings = {
  g = {
    mapleader = " ",
    maplocalleader = " ",
  },
  opt = {
    number = true,
    relativenumber = true,
    mouse = "a",
    clipboard = "unnamedplus",
    signcolumn = "yes:2",
    cursorline = true,
    showmatch = true,
    ignorecase = true,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    hlsearch = true,
    incsearch = true,
    inccommand = "nosplit",
    -- wrap = true,
    -- wrapmargin = 1,
    expandtab = true,
    softtabstop = 2,
    tabstop = 2,
    shiftwidth = 2,
    shiftround = true,
    autoindent = true,
    smartindent = true,
    preserveindent = true,
    copyindent = true,
    breakindent = true,
    smarttab = true,
    autowrite = true,
    confirm = true,
    timeout = true,
    timeoutlen = 1000,
    foldenable = true,
    foldcolumn = "0",
    foldlevel = 99,
    foldlevelstart = 99,
    termguicolors = true,
    ttyfast = true,
    wildmode = "longest,list",
    -- fillchars = {
    --   fold = "•",
    --   eob = " ",
    --   horiz = "━",
    --   horizup = "┻",
    --   horizdown = "┳",
    --   vert = "┃",
    --   vertleft = "┫",
    --   vertright = "┣",
    --   verthoriz = "╋",
    -- },
    -- shortmess = {
    --   A = true,
    --   c = true,
    --   F = true,
    --   I = true,
    --   W = true,
    -- },
    backup = false,
    writebackup = false,
    backupdir = vim.fn.stdpath("data") .. "/backups",
    updatetime = 100,
    swapfile = false,
    directory = vim.fn.stdpath("data") .. "/swaps",
    undofile = true,
    undolevels = 10000,
    undodir = vim.fn.stdpath("data") .. "/undos",
  },
}

for mode, options in pairs(settings) do
  for option, value in pairs(options) do
    vim[mode][option] = value
  end
end

local disabled_plugins = {
  -- "2html_plugin",
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
