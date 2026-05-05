return {
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
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          "${3rd}/luv/library",
        },
      },
      hint = {
        enable = true,
      },
      completion = {
        enable = true,
        callSnippet = "Replace",
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
      format = { enable = true },
    },
  },
}
