return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  keys = {
    {
      "<leader>ml",
      "<cmd>MarkdownPreviewToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle markdown preview" },
    },
  },
  ft = { "markdown" },
}
