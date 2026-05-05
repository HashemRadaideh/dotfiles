local utils = require("plugins.ui.lualine.utils")

local filetype_filename_opts = {
  icon_colored = true,
  filename_colored = false,
  icon_side = "left",
}

return {
  function()
    local filename = vim.fn.expand("%:t")
    if filename == "" then
      filename = "[Untitled]"
    end
    local modified = vim.bo.modified and " ●" or ""
    local icon, icon_hl = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, { default = false })

    local icon_str = icon
    if icon ~= "" and filetype_filename_opts.icon_colored and icon_hl then
      if filetype_filename_opts.filename_colored then
        icon_str = "%#" .. icon_hl .. "#" .. icon
      else
        local mode_map = { n = "normal", i = "insert", v = "visual", V = "visual", R = "replace", c = "command" }
        local m = mode_map[vim.fn.mode()] or "normal"
        icon_str = "%#" .. icon_hl .. "#" .. icon .. "%#lualine_c_" .. m .. "#"
      end
    end

    if icon_str ~= "" then
      if filetype_filename_opts.icon_side == "right" then
        return filename .. modified .. " " .. icon_str
      else
        return icon_str .. " " .. filename .. modified
      end
    end

    return filename .. modified
  end,
  color = function()
    if not filetype_filename_opts.filename_colored then
      return nil
    end
    local ft = vim.bo.filetype
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local _, hl = devicons.get_icon_by_filetype(ft, { default = false })
      if hl then
        local fg = vim.fn.synIDattr(vim.fn.hlID(hl), "fg")
        if fg and fg ~= "" then
          return { fg = fg }
        end
      end
    end
  end,
  cond = utils.hide_buffertypes,
}