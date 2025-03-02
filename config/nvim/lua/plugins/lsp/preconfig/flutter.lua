return {
  "akinsho/flutter-tools.nvim",
  ft = { "dart" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  -- config = true,
  config = function()
    local config = require("plugins.lsp.config")
    require("flutter-tools").setup({
      lsp = {
        on_attach = config.on_attach,
        capabilities = config.capabilities,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
            vim.fn.expand("$HOME/.pub-cache"),
            vim.fn.expand("/opt/homebrew"),
            vim.fn.expand("$HOME/tools/flutter"),
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    })
  end,
}
