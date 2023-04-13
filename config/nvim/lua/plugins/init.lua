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

require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'

    use {
      'neovim/nvim-lspconfig',
      requires = {
        { 'williamboman/mason.nvim', run = ':MasonUpdate' },
        'williamboman/mason-lspconfig.nvim',
        {
          "hrsh7th/nvim-cmp",
          requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline"
          },
        },
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "jose-elias-alvarez/null-ls.nvim",
      },
      config = function()
        require('plugins.lsp')
      end
    }

    -- use 'projekt0n/github-nvim-theme'

    -- use 'navarasu/onedark.nvim' -- 'ful1e5/onedark.nvim'

    -- use 'catppuccin/nvim'

    -- use 'EdenEast/nightfox.nvim'

    -- use 'sainnhe/edge'

    -- use 'dylanaraps/wal.vim'

    -- use 'ellisonleao/gruvbox.nvim'

    -- use 'shaunsingh/nord.nvim'

    -- use 'Shatur/neovim-ayu'

    use 'folke/tokyonight.nvim'

    use {
      'folke/which-key.nvim',
      config = function()
        require('plugins.whichkey')
      end
    }

    use {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.todocomments')
      end
    }

    use {
      'folke/zen-mode.nvim',
      config = function()
        require('plugins.zenmode')
      end
    }

    use {
      'folke/twilight.nvim',
      config = function()
        require('plugins.twilight')
      end
    }

    use 'tpope/vim-fugitive'

    use 'tpope/vim-surround'

    use 'tpope/vim-commentary'

    use 'vim-scripts/ReplaceWithRegister'

    use 'mg979/vim-visual-multi'

    use 'bkad/CamelCaseMotion'

    use 'easymotion/vim-easymotion'

    -- use 'justinmk/vim-sneak'

    use {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        require('plugins.hop')
      end
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugins.indent')
      end
    }

    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('plugins.colorizer')
      end
    }


    use {
      'kevinhwang91/nvim-bqf',
      ft = 'qf',
      config = function()
        require('plugins.bqf')
      end
    }

    use {
      'junegunn/fzf',
      run = function()
        vim.fn['fzf#install']()
      end
    }

    use {
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
    }

    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        {
          -- only needed if you want to use the commands with '_with_window_picker' suffix
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
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
        require('plugins.lualine')
      end
    }

    use {
      'akinsho/bufferline.nvim',
      tag = 'v3.*',
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        -- require('bufferline').setup()
        require('plugins.bufferline')
      end
    }

    use 'rcarriga/nvim-notify'

    use {
      'simrat39/symbols-outline.nvim',
      config = function()
        require('plugins.outline')
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require('plugins.autopairs')
      end
    }

    use {
      'goolord/alpha-nvim',
      requires = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('plugins.alpha')
        -- require'alpha'.setup(require'alpha.themes.startify'.config)
      end
    }

    use {
      'metakirby5/codi.vim',
      config = function()
        vim.cmd [[
          let g:codi#rightalign = 1
          let g:codi#rightsplit = 1
        ]]
      end
    }

    use 'github/copilot.vim'

    use {
      'AckslD/nvim-gfold.lua',
      config = function()
        require('plugins.gfold')
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      tag = 'release', -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
      config = function()
        require('plugins.gitsigns')
      end
    }

    use {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.diffview')
      end
    }

    use {
      'Shatur/neovim-session-manager',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.session')
      end
    }

    if packer_bootstrap then
      require('packer').sync()
    end

    require('plugins.theme')
  end,
  compile_path = require('packer.util').join_paths(vim.fn.stdpath('config'), 'lua', 'plugins', 'packer.lua'),
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
