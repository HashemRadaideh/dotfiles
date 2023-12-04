local ok, indent_blankline = pcall(require, "ibl")
if not ok then
  return
end

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
  -- "Whitespace",
  -- "CursorColumn",
  -- "NonText"
}

local hooks = require "ibl.hooks"

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }

indent_blankline.setup {
  indent = { highlight = highlight, char = '│' }, -- '│' '║'
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { highlight = highlight },
  exclude = {
    -- language = { "rust" },
    -- node_type = { lua = { "block", "chunk" } },
    buftypes = {
      "nofile",
      "terminal",
      "lsp-installer",
      "lspinfo",
    },
    filetypes = {
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
  }
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

-- indent_blankline.setup({
-- enabled = true,
-- context_patterns = {
--   "class",
--   "return",
--   "function",
--   "method",
--   "^if",
--   "^while",
--   "jsx_element",
--   "^for",
--   "^object",
--   "^table",
--   "block",
--   "arguments",
--   "if_statement",
--   "else_clause",
--   "jsx_element",
--   "jsx_self_closing_element",
--   "try_statement",
--   "catch_clause",
--   "import_statement",
--   "operation_type",
-- },
-- use_treesitter = true,
-- show_end_of_line = true,
-- show_current_context = true,
-- show_current_context_start = true,
-- show_trailing_blankline_indent = false,
-- show_first_indent_level = true,
-- -- space_char_blankline = " ",
-- -- blankline_char = "▏",
-- char = "│",
-- context_char = "▏",
-- })
