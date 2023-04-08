Plugins = {
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

  { "kevinhwang91/nvim-bqf", ft = "qf", },

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
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    },
  },

  -- "RRethy/vim-illuminate",



  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", },

  "p00f/nvim-ts-rainbow",

  "windwp/nvim-autopairs",

  "windwp/nvim-ts-autotag",

  "RRethy/nvim-treesitter-endwise",

  "nvim-treesitter/playground",



  "mfussenegger/nvim-dap",

  "Pocco81/dap-buddy.nvim",

  "rcarriga/nvim-dap-ui",

  "theHamsta/nvim-dap-virtual-text",

  -- { "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" },

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

  { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", },

  { "s1n7ax/nvim-window-picker", tag = "v1.*", },

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
  --   run = "cd app && npm install",
  --   setup = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- }
}

Configs = {
  "plugins_packed",
  "plugins.ui.theme",
  "plugins.ui.lualine",
  "plugins.ui.bufferline",
  "plugins.ui.alpha",
  "plugins.ui.notify",
  "plugins.ui.whichkey",
  "plugins.ui.bqf",
  "plugins.ui.indent",
  "plugins.ui.cinnamon",
  "plugins.ui.shade",
  "plugins.ui.twilight",
  "plugins.ui.zenmode",
  "plugins.ui.todocomments",
  "plugins.ui.colorizer",
  "plugins.ui.rangehighlight",

  "plugins.git.gitsigns",
  "plugins.git.diffview",
  "plugins.git.gfold",

  "plugins.lsp.init",

  "plugins.dap.init",

  "plugins.ts.treesitter",
  "plugins.ts.autopairs",

  "plugins.neotree",
  "plugins.windowpicker",
  "plugins.telescope",
  "plugins.toggleterm",
  "plugins.toggletasks",
  "plugins.comment",
  "plugins.sessions",
}

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  ---@diagnostic disable-next-line: lowercase-global
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
end

require("packer").startup({
  function(use)
    if packer_bootstrap then
      require("packer").sync()
    end

    for _, plugin in ipairs(Plugins) do
      use(plugin)
    end

    for _, config in ipairs(Configs) do
      require(config)
    end
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/plugins_packed.lua",
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
      subcommands = {
        update = "pull --rebase",
      },
    },
    auto_clean = true,
    compile_on_sync = true,
    display = {
      open_fn = require("packer.util").float,
    },
  },
  autoremove = true,
})
