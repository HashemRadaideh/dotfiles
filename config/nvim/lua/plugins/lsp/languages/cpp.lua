local config = require('plugins.lsp.configs.setup')

-- require('lspconfig')
--     .clangd.setup(config)

local clangd_capabilities = require("cmp_nvim_lsp").default_capabilities(config.capabilities)
-- clangd_capabilities.textDocument.semanticHighlighting = true
clangd_capabilities.offsetEncoding = "utf-8"

require('lspconfig').clangd.setup {
    capabilities = clangd_capabilities,
    on_attach = config.on_attach,
    handlers = config.handlers,
    flags = config.flags,
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
}
