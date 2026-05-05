local orig_notify_once = vim.notify_once
---@diagnostic disable-next-line: duplicate-set-field
vim.notify_once = function(msg, level, opts)
  if type(msg) == "string" and msg:find("deprecated", 1, true) then
    return false
  end
  return orig_notify_once(msg, level, opts)
end

local orig_notify = vim.notify
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:find("deprecated", 1, true) then
    return
  end
  orig_notify(msg, level, opts)
end