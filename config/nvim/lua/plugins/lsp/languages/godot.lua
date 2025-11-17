local config = require("plugins.lsp.config")

vim.lsp.config("gdscript", config)
vim.lsp.enable("gdscript")

vim.lsp.config("gdshader_lsp", config)
vim.lsp.enable("gdshader_lsp")

if vim.fn.filereadable(vim.fs.find({ "project.godot" }, { upward = true })[1]) == 1 then
  vim.fn.serverstart("./godothost")
end
