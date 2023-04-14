local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
  return
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

indent_blankline.setup({
  enabled = true,
  buftype_exclude = {
    "nofile",
    "terminal",
    "lsp-installer",
    "lspinfo",
  },
  filetype_exclude = {
    "help",
    "startify",
    "aerial",
    "alpha",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "neo-tree",
    "Trouble",
    "lazy",
  },
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
  use_treesitter = true,
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  -- space_char_blankline = " ",
  -- blankline_char = "▏",
  char = "│",
  context_char = "▏",
})
