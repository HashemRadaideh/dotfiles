local ok, notify = pcall(require, "notify")
if not ok then
  return
end

vim.notify = notify.setup({
  background_colour = "#000000",
  fps = 60,
  render = "wrapped-compact",
  stages = "fade",
  timeout = 500,
  top_down = false
})
