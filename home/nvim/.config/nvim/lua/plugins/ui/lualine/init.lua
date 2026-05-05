local component = function(name)
  return require("plugins.ui.lualine.components." .. name)
end

return {
  "nvim-lualine/lualine.nvim",
  event = {
    "WinEnter",
    "BufEnter",
    "SessionLoadPost",
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "│",
      section_separators = "",
      disabled_filetypes = {
        statusline = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree" },
        winbar = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree" },
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = false,
      globalstatus = true,
      refresh = {
        statusline = 200,
        tabline = 200,
        winbar = 200,
        refresh_time = 16,
        events = {
          "WinEnter",
          "BufEnter",
          "BufWritePost",
          "SessionLoadPost",
          "FileChangedShellPost",
          "VimResized",
          "Filetype",
          "CursorMoved",
          "CursorMovedI",
          "ModeChanged",
        },
      },
    },
    sections = {
      lualine_a = { component("mode") },
      lualine_b = {
        -- require("auto-session.lib").current_session_name,
        -- component("project"),
        component("projectname"),
        component("gitbranch"),
      },
      lualine_c = {
        component("filetype_filename"),
        -- component("filename"),
        component("gitstatus"),
        component("diagnostics"),
      },
      lualine_x = {
        component("mcphub"),
        component("schema-companion"),
        -- component("filetype"),
      },
      lualine_y = {
        component("lspstatus"),
        -- component("progress"),
        component("location"),
      },
      lualine_z = {
        -- component("spaces"),
        -- component("encoding"),
        component("fileformat"),
      },
    },
    inactive_sections = {
      lualine_a = { component("filename") },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { component("filetype") },
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
