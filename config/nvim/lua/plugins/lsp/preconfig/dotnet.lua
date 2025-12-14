return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
      {
        "tris203/rzls.nvim",
        config = true,
      },
    },
    config = function()
      vim.lsp.enable("rzls")
      vim.lsp.enable("roslyn")
    end,
    init = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
