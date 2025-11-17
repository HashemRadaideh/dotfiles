return {
  "williamboman/mason-lspconfig.nvim",
  -- event = { "LspAttach" },
  lazy = false,
  opts = {
    automatic_installation = true,
    ensure_installed = {
      "arduino_language_server",
      "bashls",
      "clangd",
      "cmake",
      "csharp_ls",
      "gopls",
      "gradle_ls",
      "html",
      "intelephense",
      "jsonls",
      "kotlin_language_server",
      "ltex",
      "lua_ls",
      "matlab_ls",
      "omnisharp",
      "pylsp",
      "pyright",
      "rust_analyzer",
      "sqlls",
      "ts_ls",
      "vimls",
      "zls",
      "taplo",
      "asm_lsp",
      "cssls",
      "somesass_ls",
      "tailwindcss",
      "cssmodules_ls",
      "svelte",
      "graphql",
      "emmet_ls",
      "prismals",
      "clojure_lsp",
      "nil_ls",
      "rnix",
      "hyprls",
      "slint_lsp",
      "mesonlsp",
      -- "gleam",
      -- "gdscript",
      -- "gdshader_lsp",
      "protols",
      "lemminx",
      "biome",
      "fsautocomplete",
      "dockerls",
      "docker_compose_language_service",
      "marksman",
      -- "sourcekit",
      "buf_ls",
      "ruby_lsp",
      "eslint",
    },
  },
}
-- return {
--   "williamboman/mason-lspconfig.nvim",
--   opts = {
--     automatic_installation = true,
--     ensure_installed = {
--       -- C / C++ / sys
--       "clangd",
--       "cmake",
--       "asm_lsp",

--       -- Web
--       "html",
--       "cssls",
--       "cssmodules_ls",
--       "somesass_ls",
--       "tailwindcss",
--       "graphql",
--       "svelte",
--       "emmet_ls",

--       -- JS/TS  (use the one your lspconfig provides)
--       "ts_ls", -- or "tsserver" on older setups

--       -- General
--       "bashls",
--       "jsonls",
--       "taplo",
--       "marksman",

--       -- Lua
--       "lua_ls",

--       -- Python
--       "pyright",
--       "pylsp",

--       -- Java / JVM
--       "kotlin_language_server",
--       "gradle_ls",

--       -- Go
--       "gopls",

--       -- Rust
--       "rust_analyzer",

--       -- PHP
--       "intelephense",
--       "prismals",

--       -- .NET / C#
--       "csharp_ls", -- or "omnisharp" (pick one)

--       -- F#
--       "fsautocomplete",

--       -- SQL
--       "sqlls",

--       -- Nix
--       "nil_ls", -- prefer nil_ls or nixd instead of rnix

--       -- XML / YAML / TOML
--       "lemminx",
--       "zls", -- zig
--       -- extras
--       "mesonlsp",
--       "slint_lsp",
--       "hyprls",
--       "dockerls",
--       "docker_compose_language_service",
--       "ruby_lsp",
--       "eslint",
--       "biome",
--       "ltex",
--       "matlab_ls",
--       "vimls",
--     },
--   },
-- }
