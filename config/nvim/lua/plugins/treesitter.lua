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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
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
