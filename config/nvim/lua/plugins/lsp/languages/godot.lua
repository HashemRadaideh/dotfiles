local config = require("plugins.lsp.config")

require("lspconfig").gdscript.setup(config)

require("lspconfig").gdshader_lsp.setup(config)

if vim.fn.filereadable(vim.fs.find({ "project.godot" }, { upward = true })[1]) == 1 then
  vim.fn.serverstart("./godothost")
end
