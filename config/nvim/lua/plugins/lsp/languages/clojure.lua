local config = require("plugins.lsp.config")

vim.lsp.config("clojure_lsp", config)
vim.lsp.enable("clojure_lsp")
