local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

require("plugins.lsp.configs.mason")
require("plugins.lsp.configs.nullls")
require("plugins.lsp.configs.cmp")

-- require('neodev').setup()
require("trouble").setup()
-- require("inlay-hints").setup()
require("lsp-inlayhints").setup()
require("fidget").setup()

require('plugins.lsp.languages')
