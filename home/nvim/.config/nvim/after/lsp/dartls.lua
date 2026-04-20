return {
  settings = {
    dart = {
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("/opt/homebrew"),
        vim.fn.expand("$HOME/tools/flutter"),
      },
    },
  },
}
