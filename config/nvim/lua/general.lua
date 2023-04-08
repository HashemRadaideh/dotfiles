local path = debug.getinfo(1).short_src

_, _, Path = string.find(path, "(.*nvim)")

-- TODO: get username from system
Username = "Hashem" -- NOTE: this is not the best solution, but it works for now

Shade = true

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



  -- 'angularls',
  -- 'ansiblels',
  -- 'apex_ls',
  -- 'astro',
  -- 'beancount',
  -- 'bicep',
  -- 'bsl_ls', -- (onescript)
  -- 'clarity_lsp',
  -- 'clojure_lsp',
  -- 'codeqlls',
  -- 'crystalline',
  -- 'cucumber_language_server',
  -- 'denols',
  -- 'dhall_lsp_server',
  -- 'diagnosticls',
  -- 'dockerls',
  -- 'dotls',
  -- 'efm',
  -- 'elixirls',
  -- 'elmls',
  -- 'ember',
  -- 'emmet_ls',
  -- 'erlangls',
  -- 'esbonio', -- (sphinx)
  -- 'flux_lsp',
  -- 'foam_ls', --  (OpenFOAM)
  -- 'fortls', --  (fortran)
  -- 'graphql',
  -- 'groovyls',
  -- 'haxe_language_server',
  -- 'hls', --  (haskell)
  -- 'hoon_ls',
  -- 'julials',
  -- 'lelwel_ls',
  -- 'lemminx', --  (xml)
  -- 'mm0_ls', -- (metamath-zero)
  -- 'nickel_ls',
  -- 'nimls',
  -- 'ocamlls deprecated',
  -- 'ocamllsp',
  -- 'opencl_ls',
  -- 'perlnavigator',
  -- 'prismals',
  -- 'puppet',
  -- 'purescriptls',
  -- 'r_language_server', -- (R)
  -- 'reason_ls',
  -- 'rescriptls',
  -- 'rnix',
  -- 'robotframework_ls',
  -- 'salt_ls', -- (sls)
  -- 'scry', -- (crystal)
  -- 'serve_d', -- (d)
  -- 'slint_lsp',
  -- 'solang', -- (solidity)
  -- 'solargraph', -- (ruby)
  -- 'solc', -- (solidity)
  -- 'solidity_ls',
  -- 'sorbet', -- (ruby)
  -- 'sourcekit', -- (swift)
  -- 'sqlls',
  -- 'sqls',
  -- 'stylelint_lsp',
  -- 'svelte',
  -- 'teal_ls',
  -- 'terraformls',
  -- 'tflint', -- (terraform)
  -- 'theme_check', -- (liquid)
  -- 'vala_ls',
  -- 'visualforce_ls',
  -- 'vls', -- (vlang, V)
  -- 'volar', -- (vue)
  -- 'vuels',
  -- 'wgsl_analyzer',
  -- 'yamlls',
}
