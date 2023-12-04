local config = require('plugins.lsp.configs.setup')

local str = vim.cmd [[f]]
local is_gradle = str:match(".*%.gradle.*")

if is_gradle then
    require('lspconfig')
        .kotlin_language_server.setup(config)
else
    require('lspconfig')
        .gradle_ls.setup({
        capabilities = config.capabilities,
        on_attach = config.on_attach,
        handlers = config.handlers,
        flags = config.flags,
        filetypes = { 'groovy', 'kotlin' },
    })
end
