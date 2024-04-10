return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
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
}
