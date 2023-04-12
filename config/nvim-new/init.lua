local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

Servers = { -- FIX: language servers
  -- Assembly
  -- 'asm_lsp',

  -- C/C++
  "clangd",
  -- 'ccls', -- (c, c++, objective-c)

  -- CMake
  "cmake",

  -- Java
  -- 'jdtls', -- (java)

  -- Kotlin
  -- 'kotlin_language_server',

  -- Lua
  "lua_ls",

  -- Python
  "pylsp",
  -- "pyright",
  -- "sourcery",
  -- "jedi_language_server",

  -- JavaScript/TypeScript
  "tsserver",
  -- "rome",
  -- "eslint",
  -- 'quick_lint_js',

  -- Json
  -- 'jsonls',
  -- 'jsonnet_ls',

  -- CSS
  "cssls",
  "cssmodules_ls",

  -- tailwindcss
  "tailwindcss",

  -- HTML
  "html",

  -- PHP
  "intelephense",
  -- 'phpactor',
  -- 'psalm', --  (php)

  -- Rust
  "rust_analyzer",

  -- toml
  -- 'taplo', -- (toml)

  -- Go
  -- 'gopls', -- (go)
  -- 'golangci_lint_ls', --  (go)

  -- dart
  -- 'dartls',

  -- Shell script (bash/zsh)
  "bashls",

  -- Awk
  "awk_ls",

  -- C#
  "omnisharp",
  -- 'csharp_ls', -- (c#)

  -- F#
  -- 'fsautocomplete', -- (f#)

  -- Powershell
  -- "powershell_es",

  -- Markdown
  -- 'marksman', -- (markdown)
  -- 'prosemd_lsp', -- (markdown)
  -- 'remark_ls', -- (markdown)
  -- 'zk', -- (markdown)

  -- Latex
  -- 'ltex', -- (latex)
  -- 'texlab', -- (latex)

  -- Vim
  'vimls',

  -- Zig
  -- 'zls', -- (zig)

  -- Arduino
  -- 'arduino_language_server',

  -- verilog
  -- 'svlangserver', -- (systemverilog)
  -- 'svls', -- (systemverilog)
  -- 'verible', -- (systemverilog, verilog)

  -- Grammar
  'grammarly',
}

require('configs')
require('plugins')
