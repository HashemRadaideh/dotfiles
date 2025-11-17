local config = require("plugins.lsp.config")

vim.lsp.config("docker_compose_language_service", config)
vim.lsp.enable("docker_compose_language_service")

vim.lsp.config("dockerls", config)
vim.lsp.enable("dockerls")
