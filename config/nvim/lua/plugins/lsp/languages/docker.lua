local config = require("plugins.lsp.config")

vim.lsp.enable("docker_compose_language_service")
vim.lsp.config("docker_compose_language_service", config)

vim.lsp.enable("dockerls")
vim.lsp.config("dockerls", config)
