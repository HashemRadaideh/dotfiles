return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<leader>mt", "<cmd>TSModuleInfo<CR>", { noremap = true, silent = true } },
  },
  dependencies = {
    -- {
    --   "nvim-treesitter/nvim-treesitter-textobjects",
    --   config = function()
    --     -- When in diff mode, we want to use the default
    --     -- vim text objects c & C instead of the treesitter ones.
    --     local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
    --     local configs = require("nvim-treesitter.configs")
    --     for name, fn in pairs(move) do
    --       if name:find("goto") == 1 then
    --         move[name] = function(q, ...)
    --           if vim.wo.diff then
    --             local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
    --             for key, query in pairs(config or {}) do
    --               if q == query and key:find("[%]%[][cC]") then
    --                 vim.cmd("normal! " .. key)
    --                 return
    --               end
    --             end
    --           end
    --           return fn(q, ...)
    --         end
    --       end
    --     end
    --   end,
    -- },
    {
      "nvim-treesitter/nvim-treesitter-context",
      -- event = "LazyFile",
      enabled = true,
      opts = { mode = "cursor", max_lines = 3 },
    },
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local ok, installer = pcall(require, "nvim-treesitter.install")
    if not ok then
      return
    end

    installer.compilers = { "clang", "zig", "gcc", "g++", "cl", "cc", "CC" }

    ---@diagnostic disable-next-line: redefined-local
    local ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return
    end

    treesitter.setup({
      auto_install = true,
      ensure_installed = {},
      sync_install = false,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
      },
      indent = {
        enable = true,
      },
      -- context_commentstring = {
      --   enable = true,
      --   enable_autocmd = false,
      -- },
      incremental_selection = {
        enable = true,
      },
      autopairs = {
        enable = true,
      },
      -- autotag = {
      --   enable = true,
      -- },
      endwise = {
        enable = true,
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    })

    require("ts_context_commentstring").setup()
    vim.g.skip_ts_context_commentstring_module = true

    require("treesitter-context").setup({
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 20, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 30, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })

    vim.cmd([[
      hi TreesitterContext guibg=none ctermbg=none
      hi TreesitterContextLineNumber guibg=none ctermbg=none
      hi TreesitterContextSeparator guibg=none ctermbg=none
      hi TreesitterContextBottom guibg=none ctermbg=none
    ]])

    vim.filetype.add({
      extension = {
        mdx = "mdx",
      },
    })
    vim.treesitter.language.register("markdown", "mdx")
  end,
}
