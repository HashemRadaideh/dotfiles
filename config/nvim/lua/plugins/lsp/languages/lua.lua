local config = require("plugins.lsp.config")

require("lspconfig").lua_ls.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        special = { reload = "require" },
        path = {
          "?.lua",
          "?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = true,
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        --   vim.fn.expand("$VIMRUNTIME/lua"),
        --   vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
        --   vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
        -- },
      },
      hint = {
        enable = true,
      },
      completion = {
        enable = true,
        -- callSnippet = "Replace",
      },
      diagnostics = {
        enable = true,
        unusedLocalExclude = {
          "_*",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
