local config = require('plugins.lsp.configs.setup')

-- require('lspconfig')
--     .dartls.setup({
--     capabilities = config.capabilities,
--     on_attach = config.on_attach,
--     handlers = config.handlers,
--     flags = config.flags,
--     settings = {
--         dart = {
--             analysisExcludedFolders = {
--                 vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
--                 vim.fn.expand("$HOME/.pub-cache"),
--                 vim.fn.expand("/opt/homebrew"),
--                 vim.fn.expand("$HOME/tools/flutter"),
--             }
--         }
--     }
-- })

local ok, flutter_tools = pcall(require, "flutter-tools")
if not ok then
    return
end

flutter_tools.setup({
    lsp = {
        on_attach = config.on_attach,
        capabilities = config.capabilities,
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {
                vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
                vim.fn.expand("$HOME/.pub-cache"),
                vim.fn.expand("/opt/homebrew"),
                vim.fn.expand("$HOME/tools/flutter"),
            },
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
        }
    }
})
