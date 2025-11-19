local config = require("plugins.lsp.config")

vim.lsp.enable("cssls")
vim.lsp.config("cssls", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  settings = {
    css = {
      -- customData = {
      --   ".vscode/css_custom_data.json",
      --   vim.fn.stdpath("config") .. "/lua/plugins/lsp/languages/css_custom_data.json",
      -- },
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

vim.lsp.enable("somesass_ls")
vim.lsp.config("somesass_ls", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  settings = {
    somesass = {},
  },
})

-- vim.lsp.enable("css_variables")
-- vim.lsp.config("css_variables",  config)

-- vim.lsp.enable("cssmodules_ls")
-- vim.lsp.config("cssmodules_ls",  config)

vim.lsp.enable("tailwindcss")
vim.lsp.config("tailwindcss", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
})

-- vim.lsp.enable("unocss")
-- vim.lsp.config("unocss",  config)
