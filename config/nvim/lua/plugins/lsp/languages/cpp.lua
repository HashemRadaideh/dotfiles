local config = require("plugins.lsp.config")

-- config.capabilities.textDocument.semanticHighlighting = true
config.capabilities.offsetEncoding = "utf-8"

vim.lsp.enable("clangd")
vim.lsp.config("clangd", {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  handlers = config.handlers,
  flags = config.flags,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  -- cmd = {
  --     "clangd",
  --     "--all-scopes-completion",
  --     "--log=info",
  --     "--enable-config",
  --     "--background-index",
  --     "--pch-storage=memory",
  --     "--clang-tidy",
  --     -- "--suggest-missing-includes",
  --     -- "--cross-file-rename",
  --     "--completion-style=detailed",
  --     -- "--index",
  --     "--header-insertion=iwyu",
  --     "--function-arg-placeholders",

  --     "--fallback-style=Google",
  --     -- "--style=\"{ BasedOnStyle: Google, IndentWidth: 2, ColumnLimit: 80, IndentCaseLabels: true, IndentPPDirectives: BeforeHash }\"",
  -- },
  -- init_options = {
  --     clangdFileStatus = true,
  --     usePlaceholders = true,
  --     completeUnimported = true,
  --     semanticHighlighting = true,
  -- },
})
