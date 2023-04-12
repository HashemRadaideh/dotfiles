local ok, windowpicker = pcall(require, "window-picker")
if not ok then
  return
end

windowpicker.setup()
