local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'wbthomason/packer.nvim',

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
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline'
        },
      },
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('plugins.lsp')
    end
  },

  -- 'projekt0n/github-nvim-theme'

  -- 'navarasu/onedark.nvim' -- 'ful1e5/onedark.nvim'

  -- 'catppuccin/nvim'

  -- 'EdenEast/nightfox.nvim'

  -- 'sainnhe/edge'

  -- 'dylanaraps/wal.vim'

  -- 'ellisonleao/gruvbox.nvim'

  -- 'shaunsingh/nord.nvim'

  -- 'Shatur/neovim-ayu'

  'folke/tokyonight.nvim',

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

  'tpope/vim-fugitive',

  'tpope/vim-surround',

  'tpope/vim-commentary',

  'vim-scripts/ReplaceWithRegister',

  'mg979/vim-visual-multi',

  'bkad/CamelCaseMotion',

  'easymotion/vim-easymotion',

  -- 'justinmk/vim-sneak'

  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('plugins.hop')
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
    tag = '0.1.x',
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
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        -- only needed if you want to the commands with '_with_window_picker' suffix
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine')
    end
  },

  {
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- require('bufferline').setup()
      require('plugins.bufferline')
    end
  },

  'rcarriga/nvim-notify',

  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('plugins.outline')
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end
  },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugins.alpha')
      -- require'alpha'.setup(require'alpha.themes.startify'.config)
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

  'github/copilot.vim',

  {
    'AckslD/nvim-gfold.lua',
    config = function()
      require('plugins.gfold')
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    tag = 'release', -- To the latest release (do not this if you build Neovim nightly or dev builds!)
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
    'Shatur/neovim-session-manager',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.session')
    end
  }
})

require('plugins.theme')
