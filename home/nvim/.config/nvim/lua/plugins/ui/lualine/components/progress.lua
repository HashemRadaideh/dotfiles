local utils = require("plugins.ui.lualine.utils")

return {
  function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local line_ratio = current_line / total_lines
    local chars = { "█", "▇", "▆", "▅", "▄", "▃", "▂", "▁", "▁", " " } -- "_",
    local index = math.ceil(line_ratio * #chars)
    return math.floor(line_ratio * 100) .. "%% │ " .. chars[index]
  end,
  cond = utils.hide_in_width,
}