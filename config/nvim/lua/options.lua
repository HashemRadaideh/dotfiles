Homedir = os.getenv("HOME")
Sessiondir = vim.fn.stdpath("data") .. "/sessions"

vim.cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

local settings = {
  wo = {
    number = true,
    relativenumber = true,

    scrolloff = 10,
    sidescrolloff = 10,

    -- numberwidth = 2,
    -- signcolumn = "yes:2",
    -- colorcolumn = "80,120", -- Make a ruler at 80px and 120px

    wrap = true,
  },
  bo = {
    expandtab = true, -- Use spaces instead of tabs
    softtabstop = 2, -- Number of spaces tabs count for
    tabstop = 2, -- Number of spaces in a tab

    shiftwidth = 2, -- Size of an indent
    autoindent = true,
    smartindent = true, -- Insert indents automatically

    wrapmargin = 1,
  },
  g = {
    mapleader = " ",
    do_filetype_lua = 1,
    -- did_load_filetypes = 0,
    highlighturl_enabled = true,
    zipPlugin = false,
  },
  opt = {
    -- mouse = "nicr",
    mouse = "a",
    clipboard = "unnamedplus",
    backspace = { "indent", "eol", "start" },

    cursorline = true,
    cursorlineopt = "screenline,number",

    fillchars = {
      eob = " ",
      horiz = "━",
      horizup = "┻",
      horizdown = "┳",
      vert = "┃",
      vertleft = "┫",
      vertright = "┣",
      verthoriz = "╋",
    },
    shortmess = {
      A = true, -- ignore annoying swap file messages
      c = true, -- Do not show completion messages in command line
      F = true, -- Do not show file info when editing a file, in the command line
      I = true, -- Do not show the intro message
      W = true, -- Do not show "written" in command line when writing
    },

    timeout = true, -- This option and "timeoutlen" determine the behavior when part of a mapped key sequence has been received. This is on by default but being explicit!
    timeoutlen = 1000, -- Time in milliseconds to wait for a mapped sequence to complete.
    updatetime = 300, -- If in this many milliseconds nothing is typed, the swap file will be written to disk. Also used for CursorHold autocommand
    history = 500,

    wildmode = "list:longest", -- Command-line completion mode
    wildignore = { "*/.git/*", "*/node_modules/*" }, -- Ignore these files/folders

    preserveindent = true,
    autoindent = true,
    copyindent = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    expandtab = true,
    smarttab = true,
    smartindent = true,
    ignorecase = true,
    smartcase = true,
    shiftround = true,

    splitbelow = true,
    splitright = true,

    completeopt = { "menuone", "noinsert", "noselect" },
    -- completeopt-=preview,
    hlsearch = true,
    incsearch = true,
    hidden = true,

    exrc = true,
    swapfile = false,
    directory = vim.fn.stdpath("data") .. "/swaps",

    backup = false,
    writebackup = false,
    backupdir = vim.fn.stdpath("data") .. "/backups",

    undofile = true,
    undolevels = 1000,
    undodir = vim.fn.stdpath("data") .. "/undos",

    showmode = false,
    showtabline = 2,
    showmatch = true,
    -- showcmd = true,

    fileencoding = "utf-8",
    -- autochdir = true,

    pumheight = 10,
    cmdheight = 1,
    conceallevel = 0,

    foldenable = false, -- Enable folding
    foldlevel = 0, -- Fold by default
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    modelines = 0, -- Only use folding settings for this file

    sessionoptions = "buffers,curdir,folds,winpos,winsize", -- Session options to store in the session
    shada = "!,'0,f0,<50,s10,h",
    -- shell = "/bin/zsh",
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
