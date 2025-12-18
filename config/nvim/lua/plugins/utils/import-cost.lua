return {
  "barrett-ruth/import-cost.nvim",
  ft = { "javascript", "typescript", "typescriptreact", "vue", "svelte" },
  build = vim.fn.has("win32") == 1 and "pwsh install.ps1 npm" or "sh install.sh npm",
  config = true,
}
