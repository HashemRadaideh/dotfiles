return {
  "barrett-ruth/import-cost.nvim",
  ft = { "javascript", "typescript", "typescriptreact", "vue", "svelte" },
  config = function()
    vim.g.import_cost = {
      package_manager = "bun",
    }
  end,
}
