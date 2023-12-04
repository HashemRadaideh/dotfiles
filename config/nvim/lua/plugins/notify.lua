local ok, notify = pcall(require, "notify")
if not ok then
  return
end

vim.notify = notify.setup({
  background_colour = "#000000",
})
