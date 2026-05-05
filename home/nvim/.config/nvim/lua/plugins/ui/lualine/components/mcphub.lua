return {
  function()
    if not vim.g.loaded_mcphub then
      return "󰐻 -"
    end

    local count = vim.g.mcphub_servers_count or 0
    local status = vim.g.mcphub_status or "stopped"
    local executing = vim.g.mcphub_executing

    if status == "stopped" then
      return "󰐻 -"
    end

    if executing or status == "starting" or status == "restarting" then
      local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      local frame = math.floor(vim.loop.now() / 100) % #frames + 1
      return "󰐻 " .. frames[frame]
    end

    return "󰐻 " .. count
  end,
  color = function()
    if not vim.g.loaded_mcphub then
      return { fg = "#6c7086" }
    end

    local status = vim.g.mcphub_status or "stopped"
    if status == "ready" or status == "restarted" then
      return { fg = "#50fa7b" }
    elseif status == "starting" or status == "restarting" then
      return { fg = "#ffb86c" }
    else
      return { fg = "#ff5555" }
    end
  end,
  cond = function()
    local buf_ft = vim.bo.filetype
    return string.match(string.lower(buf_ft), "avante") ~= nil
  end,
}