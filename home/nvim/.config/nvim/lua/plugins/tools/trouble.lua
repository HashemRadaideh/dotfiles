return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
    { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
    { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
    { "<leader>xr", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references / definitions" },
  },
}
