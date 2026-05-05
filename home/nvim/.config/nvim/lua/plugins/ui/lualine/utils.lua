local M = {}

function M.hide_in_width()
  return vim.fn.winwidth(0) > 80
end

function M.hide_buffertypes()
  local buf_ft = vim.bo.filetype
  return string.match(string.lower(buf_ft), "avante") == nil
end

return M