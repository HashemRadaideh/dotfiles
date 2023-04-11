local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "wbthomason/packer.nvim",

  "lewis6991/impatient.nvim",

  "nvim-lua/plenary.nvim",

  "kyazdani42/nvim-web-devicons",

  "MunifTanjim/nui.nvim",

  -- "projekt0n/github-nvim-theme",

  "navarasu/onedark.nvim", -- "ful1e5/onedark.nvim",

  -- "catppuccin/nvim",

  -- "EdenEast/nightfox.nvim",

  -- "folke/tokyonight.nvim",

  -- "sainnhe/edge",

  -- "dylanaraps/wal.vim",

  -- "ellisonleao/gruvbox.nvim",

  -- "shaunsingh/nord.nvim",

  -- "Shatur/neovim-ayu",

  "nvim-lualine/lualine.nvim",

  { "akinsho/bufferline.nvim", tag = "v2.*", },

  "goolord/alpha-nvim",

  "rcarriga/nvim-notify",

  "folke/which-key.nvim",

  { "folke/neoconf.nvim",      cmd = "Neoconf" },

  "folke/neodev.nvim",

  { "kevinhwang91/nvim-bqf",   ft = "qf", },

  "lukas-reineke/indent-blankline.nvim",

  -- "declancm/cinnamon.nvim",

  -- "sunjon/shade.nvim",

  -- "xiyaowong/nvim-transparent",

  -- "folke/twilight.nvim",

  -- "junegunn/goyo.vim",

  -- "folke/zen-mode.nvim",

  "folke/todo-comments.nvim",

  "norcalli/nvim-colorizer.lua",

  "winston0410/cmd-parser.nvim",

  "winston0410/range-highlight.nvim",



  { "lewis6991/gitsigns.nvim", tag = "release", },

  -- "sindrets/diffview.nvim",

  "kdheepak/lazygit.nvim",

  "github/copilot.vim",

  "tpope/vim-fugitive",

  "AckslD/nvim-gfold.lua",



  "stephenway/postcss.vim",

  "williamboman/mason-lspconfig.nvim",

  "williamboman/mason.nvim",

  "neovim/nvim-lspconfig",

  -- "williamboman/nvim-lsp-installer",

  -- "tami5/lspsaga.nvim",

  "jose-elias-alvarez/null-ls.nvim",

  "rafamadriz/friendly-snippets",

  "L3MON4D3/LuaSnip",

  "saadparwaiz1/cmp_luasnip",

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    },
  },

  -- "RRethy/vim-illuminate",



  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },

  "p00f/nvim-ts-rainbow",

  "windwp/nvim-autopairs",

  "windwp/nvim-ts-autotag",

  "RRethy/nvim-treesitter-endwise",

  "nvim-treesitter/playground",



  "mfussenegger/nvim-dap",

  "Pocco81/dap-buddy.nvim",

  "rcarriga/nvim-dap-ui",

  "theHamsta/nvim-dap-virtual-text",

  -- { "rcarriga/vim-ultest", dependencies = { "vim-test/vim-test" }, build = ":UpdateRemotePlugins" },

  "nvim-neotest/neotest",


  {
    "metakirby5/codi.vim",
    config = function()
      vim.cmd [[
        let g:codi#rightalign = 1
        let g:codi#rightsplit = 1
      ]]
    end
  },

  { "nvim-neo-tree/neo-tree.nvim",     branch = "v2.x", },

  { "s1n7ax/nvim-window-picker",       tag = "v1.*", },

  "nvim-telescope/telescope.nvim",

  "nvim-telescope/telescope-ui-select.nvim",

  { "akinsho/toggleterm.nvim", tag = "*", },

  -- { "jedrzejboczar/toggletasks.nvim", },

  "simrat39/symbols-outline.nvim",

  "mg979/vim-visual-multi",

  "tpope/vim-surround",

  "tpope/vim-commentary",

  "vim-scripts/ReplaceWithRegister",

  "wellle/targets.vim",

  -- "numToStr/Comment.nvim",

  "easymotion/vim-easymotion",

  "bkad/CamelCaseMotion",

  "justinmk/vim-sneak",

  -- "jghauser/mkdir.nvim",

  -- "jacquesbh/vim-showmarks",

  "Shatur/neovim-session-manager",

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   build = "cd app && npm install",
  --   setup = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- }
})

require("plugins.dap")
require("plugins.git")
require("plugins.lsp")
require("plugins.tools")
require("plugins.ts")
require("plugins.ui")
