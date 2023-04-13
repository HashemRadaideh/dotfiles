local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

Plugins = {
  'wbthomason/packer.nvim',

  {
    'neovim/nvim-lspconfig',
    requires = {
      { 'williamboman/mason.nvim', run = ':MasonUpdate' },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       config = function() require('fidget').setup() end },
      {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
          'rafamadriz/friendly-snippets',
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',
        },
      },
      'jose-elias-alvarez/null-ls.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      require('plugins.lsp')
    end
  },

  {
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify requires as well
    requires = {
      -- Creates a beautiful debugger UI
      "Pocco81/dap-buddy.nvim",
      'rcarriga/nvim-dap-ui',
      "theHamsta/nvim-dap-virtual-text",
      -- { "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" },
      "nvim-neotest/neotest",

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = function()
      require('plugins.dap')
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
    config = function()
      require('plugins.theme')
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
    requires = 'nvim-lua/plenary.nvim',
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

  'tpope/vim-rhubarb',

  'tpope/vim-surround',

  'tpope/vim-commentary',

  'tpope/vim-sleuth',

  'vim-scripts/ReplaceWithRegister',

  'mg979/vim-visual-multi',

  'bkad/CamelCaseMotion',

  {
    'https://github.com/ggandor/leap.nvim',
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
    run = function()
      vim.fn['fzf#install']()
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    requires = {
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
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    run = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    branch = 'v2.x',
    keys = { { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "NeoTree" } },
    requires = {
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
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine')
    end
  },

  {
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    requires = 'nvim-tree/nvim-web-devicons',
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
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
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
    requires = { 'nvim-tree/nvim-web-devicons' },
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
    tag = 'release',
    -- opts = {
    --   -- See `:help gitsigns.txt`
    --   signs = {
    --     add = { text = '+' },
    --     change = { text = '~' },
    --     delete = { text = '_' },
    --     topdelete = { text = '‾' },
    --     changedelete = { text = '~' },
    --   },
    -- },
    config = function()
      require('plugins.gitsigns')
    end
  },

  {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.diffview')
    end
  },

  {
    'Shatur/neovim-session-manager',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.session')
    end
  }
}

require("packer").startup({
  function(use)
    for _, plugin in ipairs(Plugins) do
      use(plugin)
    end

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    -- compile_path = vim.fn.stdpath("config") .. "/packer-lock.lua",
    profile = {
      enable = true,
      threshold = 1 -- the amount in ms that a plugin's load time must be over for it to be included in the profile
    },
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  },
})
