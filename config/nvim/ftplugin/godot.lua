if vim.fn.filereadable(vim.fs.find({ "project.godot" }, { upward = true })[1]) == 1 then
  vim.fn.serverstart("./godothost")
end
