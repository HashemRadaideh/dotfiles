local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', build = ':MasonUpdate' },
      'williamboman/mason-lspconfig.nvim',

      {
        'hrsh7th/nvim-cmp',
        dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'saadparwaiz1/cmp_luasnip',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
        },
      },

      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',

      'jose-elias-alvarez/null-ls.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
    },
    config = function()
      require('plugins.lsp')
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    build = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  },

  {
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      "Pocco81/dap-buddy.nvim",
      'rcarriga/nvim-dap-ui',
      "theHamsta/nvim-dap-virtual-text",

      "nvim-neotest/neotest",

      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      'leoluz/nvim-dap-go',
    },
    config = function()
      require('plugins.dap')
    end
  },

  { 'github/copilot.vim' },

  {
    'AckslD/nvim-gfold.lua',
    config = function()
      require('plugins.gfold')
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release',
    config = function()
      require('plugins.gitsigns')
    end
  },

  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.diffview')
    end
  },

  {
    'tpope/vim-fugitive',
    cmd = "G"
  },

  { 'tpope/vim-rhubarb', },

  { 'tpope/vim-surround', },

  { 'tpope/vim-commentary', },

  { 'tpope/vim-sleuth', },

  -- { 'vim-scripts/ReplaceWithRegister', },

  { 'mg979/vim-visual-multi', },

  { 'bkad/CamelCaseMotion', },

  {
    'ggandor/leap.nvim',
    requires = 'tpope/vim-repeat',
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('plugins.hop')
    end
  },

  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('plugins.bqf')
    end
  },

  {
    'junegunn/fzf',
    build = function()
      vim.fn['fzf#install']()
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kdheepak/lazygit.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('plugins.telescope')
    end
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = "Neotree",
    branch = 'v2.x',
    keys = { { '<leader>fe', '<cmd>Neotree toggle<CR>', desc = "Open file explorer" } },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        -- only needed if you want to the commands with '_with_window_picker' suffix
        's1n7ax/nvim-window-picker',
        -- tag = 'v1.*',
        config = function()
          require('plugins.windowpicker')
        end,
      }
    },
    config = function()
      require('plugins.neotree')
    end
  },

  {
    'mbbill/undotree',
    cmd = "UndotreeToggle",
    keys = { { '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = "Open Undotree" } },
  },

  {
    'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
    keys = { { '<leader>so', '<cmd>SymbolsOutline<CR>', desc = "Open SymbolsOutline" } },
    config = function()
      require('plugins.outline')
    end
  },

  {
    'metakirby5/codi.vim',
    config = function()
      vim.cmd [[
          let g:codi#rightalign = 1
          let g:codi#rightsplit = 1
        ]]
    end
  },

  {
    'Shatur/neovim-session-manager',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.session')
    end
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine')
    end
  },

  {
    'akinsho/bufferline.nvim',
    -- tag = 'v3.*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('plugins.bufferline')
    end
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('plugins.notify')
    end
  },

  {
    'goolord/alpha-nvim',
    -- cmd = 'Alpha',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugins.alpha')
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent')
    end
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugins.colorizer')
    end
  },

  {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup()
    end
  },

  {
    'folke/which-key.nvim',
    config = function()
      require('plugins.whichkey')
    end
  },

  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.todocomments')
    end
  },

  {
    'folke/zen-mode.nvim',
    config = function()
      require('plugins.zenmode')
    end
  },

  {
    'folke/twilight.nvim',
    config = function()
      require('plugins.twilight')
    end
  },

  {
    -- 'projekt0n/github-nvim-theme',
    'navarasu/onedark.nvim',
    -- 'catppuccin/nvim',
    -- 'EdenEast/nightfox.nvim',
    -- 'sainnhe/edge',
    -- 'dylanaraps/wal.vim',
    -- 'ellisonleao/gruvbox.nvim',
    -- 'shaunsingh/nord.nvim',
    -- 'Shatur/neovim-ayu',
    -- 'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('plugins.theme')
    end
  },
}, {})
