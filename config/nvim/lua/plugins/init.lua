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

local function tabnine_build_path()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return "pwsh.exe -file .\\dl_binaries.ps1"
  else
    return "./dl_binaries.sh"
  end
end

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
      'j-hui/fidget.nvim',
      'ray-x/lsp_signature.nvim',
      'folke/trouble.nvim',
      'RRethy/vim-illuminate',

      -- 'simrat39/inlay-hints.nvim',
      'lvimuser/lsp-inlayhints.nvim',

      'simrat39/rust-tools.nvim',
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      require('plugins.lsp')
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
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

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    cmd = {
      "ChatGPT",
    },
    keys = {
      { "<leader>ch", desc = "toggle chatgpt" },
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt ~/secret.txt.gpg 2>/dev/null"
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", desc = "summarize text" },
      { "<leader>ag", desc = "generate git message" },
      { "<leader>ai", desc = "toggle ai" },
    },
    config = function()
      require("neoai").setup()
    end,
  },

  {
    'codota/tabnine-nvim',
    build = tabnine_build_path(),
    -- cmd = {
    --   "TabnineStatus",
    --   "TabnineDisable",
    --   "TabnineEnable",
    --   "TabnineToggle",
    -- },
    -- keys = {
    --   { "<leader>tn", desc = "toggle tabnine" },
    -- },
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end
  },

  {
    'github/copilot.vim',
    cmd = "Copilot",
    keys = { { "<leader>co", desc = "toggle copilot" } }
  },

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

  { 'tpope/vim-sleuth', },

  -- { 'tpope/vim-commentary', },

  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring', },
    config = function()
      require('plugins.comment')
    end
  },

  -- { 'vim-scripts/ReplaceWithRegister', },

  { 'mg979/vim-visual-multi', },

  { 'bkad/CamelCaseMotion', },

  -- {
  --   'ggandor/leap.nvim',
  --   dependencies = { "tpope/vim-repeat", event = "VeryLazy" },
  --   config = function()
  --     require('leap').add_default_mappings()
  --   end
  -- },

  -- {
  --   'phaazon/hop.nvim',
  --   branch = 'v2',
  --   config = function()
  --     require('plugins.hop')
  --   end
  -- },

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
    {
      'akinsho/toggleterm.nvim',
      version = "*",
      config = function()
        require("plugins.toggleterm")
      end
    }
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    -- cmd = "Neotree",
    branch = 'v2.x',
    -- keys = { { '<leader>fe', '<cmd>Neotree toggle<CR>', desc = "Open file explorer" } },
    dependencies = {
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
    event = "BufReadPre",
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
    event = "VeryLazy",
    config = function()
      require('plugins.lualine')
    end
  },

  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    -- tag = 'v3.*',
    config = function()
      require('plugins.bufferline')
    end
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        attach_navic = false,   -- prevent barbecue from automatically attaching nvim-navic
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('plugins.notify')
    end
  },

  {
    "stevearc/dressing.nvim",
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end

      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    config = function()
      require('plugins.alpha')
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
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
    config = function()
      require('plugins.todocomments')
    end
  },

  {
    'folke/zen-mode.nvim',
    cmd = "ZenMode",
    keys = { { '<leader>zz', '<cmd>ZenMode<CR>', desc = "Open file explorer" } },
    dependencies = {
      'folke/twilight.nvim',
      cmd = "Twilight",
      config = function()
        require('plugins.twilight')
      end
    },
    config = function()
      require('plugins.zenmode')
    end
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc =
        "Redirect Cmdline"
      },
      {
        "<leader>snl",
        function() require("noice").cmd("last") end,
        desc =
        "Noice Last Message"
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc =
        "Noice History"
      },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll forward",
        mode = {
          "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll backward",
        mode = {
          "i", "n", "s" }
      },
    },
  },

  {
    -- 'projekt0n/github-nvim-theme',
    -- 'AlexvZyl/nordic.nvim',
    -- 'navarasu/onedark.nvim',
    'catppuccin/nvim',
    -- 'EdenEast/nightfox.nvim',
    -- 'sainnhe/edge',
    -- 'dylanaraps/wal.vim',
    -- 'ellisonleao/gruvbox.nvim',
    -- 'shaunsingh/nord.nvim',
    -- 'Shatur/neovim-ayu',
    -- 'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('plugins.theme')
    end
  },

  { "nvim-lua/plenary.nvim",       lazy = true },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "MunifTanjim/nui.nvim",        lazy = true },
}, {})
