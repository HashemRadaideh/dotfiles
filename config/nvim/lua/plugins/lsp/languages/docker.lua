local config = require("plugins.lsp.config")

require("lspconfig").docker_compose_language_service.setup(config)
require("lspconfig").dockerls.setup(config)
