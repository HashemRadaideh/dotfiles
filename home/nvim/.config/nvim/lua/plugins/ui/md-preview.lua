return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
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
}