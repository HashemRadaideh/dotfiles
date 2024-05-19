return {
  "barrett-ruth/import-cost.nvim",
  event = { "BufReadPost", "BufNewFile" },
  ft = { "javascript", "typescript", "typescriptreact", "vue", "svelte" },
  build = vim.fn.has("win32") == 1 and "pwsh install.ps1 yarn" or "sh install.sh yarn",
  config = true,
}
