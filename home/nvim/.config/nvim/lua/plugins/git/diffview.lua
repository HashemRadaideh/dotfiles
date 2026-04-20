return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewLog",
    "DiffviewRefresh",
    "DiffviewFocusFile",
    "DiffviewFileHistory",
    "DiffviewToggleFile",
  },
  deactivate = function()
    vim.cmd([[DiffviewClose]])
  end,
  opts = {},
  keys = {
    { "<leader>dfo", '<cmd>DiffviewOpen<cr>',        desc = "Open Diff View" },
    { "<leader>dfc", '<cmd>DiffviewClose<cr>',       desc = "Open Diff View" },
    { "<leader>dfl", '<cmd>DiffviewLog<cr>',         desc = "Open Diff View" },
    { "<leader>dfr", '<cmd>DiffviewRefresh<cr>',     desc = "Open Diff View" },
    { "<leader>dff", '<cmd>DiffviewFocusFile<cr>',   desc = "Open Diff View" },
    { "<leader>dfh", '<cmd>DiffviewFileHistory<cr>', desc = "Open Diff View" },
    { "<leader>dft", '<cmd>DiffviewToggleFile<cr>',  desc = "Open Diff View" },
  },
}
