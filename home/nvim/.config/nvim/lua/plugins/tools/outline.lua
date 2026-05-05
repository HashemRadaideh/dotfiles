return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>so", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    symbol_folding = {
      auto_unfold = {
        hovered = true,
      },
    },
    outline_items = {
      show_symbol_lineno = true,
      show_cursorline = true,
      hide_cursor = true,
    },
  },
}