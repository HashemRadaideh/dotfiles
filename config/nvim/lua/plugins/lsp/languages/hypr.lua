local config = require("plugins.lsp.config")

vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    ["hypr*.conf"] = "hyprland",
    [".*%.hl"] = "hyprlang",
  },
})

require("lspconfig").hyprls.setup(config)

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = { "*.hl", "hypr*.conf" },
--   callback = function()
--     -- vim.lsp.start({
--     --   name = "hyprlang",
--     --   cmd = { "hyprls" },
--     --   root_dir = vim.fn.getcwd(),
--     -- })
--   end,
-- })
