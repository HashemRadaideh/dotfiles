local config = require("plugins.lsp.config")

require("lspconfig").cssls.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  filetypes = { "css" },
  settings = {
    css = {
      customData = {
        ".vscode/css_custom_data.json",
        vim.fn.stdpath("config") .. "/lua/plugins/lsp/languages/css_custom_data.json",
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

require("lspconfig").somesass_ls.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  settings = {
    somesass = {},
  },
})

-- require("lspconfig").css_variables.setup(config)

-- require("lspconfig").cssmodules_ls.setup(config)

require("lspconfig").tailwindcss.setup(config)

-- require("lspconfig").unocss.setup(config)
