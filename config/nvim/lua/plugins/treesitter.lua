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
  ensure_installed = "all",
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
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
  autotag = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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

require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true

require 'treesitter-context'.setup {
  enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,     -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.cmd [[
  hi TreesitterContext guibg=none ctermbg=none
  hi TreesitterContextLineNumber guibg=none ctermbg=none
  hi TreesitterContextSeparator guibg=none ctermbg=none
  hi TreesitterContextBottom guibg=none ctermbg=none
]]
