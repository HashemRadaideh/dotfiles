local config = require('plugins.lsp.configs.setup')

require('lspconfig')
    .lua_ls.setup({
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      workspace = { checkThirdParty = false },
      runtime = {
        version = 'LuaJIT',
        -- path = runtime_path,
      },
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'use' },
      },
      -- workspace = {
      --   library = vim.api.nvim_get_runtime_file('', true),
      --   maxPreload = 10000,
      --   preloadFileSize = 10000,
      -- },
      telemetry = { enable = false },
      -- telemetry = { enable = true },
    },
  }
})
