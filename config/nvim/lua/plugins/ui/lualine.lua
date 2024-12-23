return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    local ok, lualine = pcall(require, "lualine")
    if not ok then
      return
    end

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = true,
      update_in_insert = true,
      always_visible = false,
    }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
      always_visible = false,
    }

    local mode = {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    }

    local filetype = {
      "filetype",
      icons_enabled = true,
      icon = nil,
      always_visible = false,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      colored = true,
      icon = "",
      always_visible = false,
    }

    local location = {
      "location",
      padding = 1,
      always_visible = false,
    }

    -- cool function for progress
    local progress = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end

    local spaces = function()
      return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    local encoding = {
      "encoding",
      -- fmt = function(str)
      --   return "encoding: " .. str
      -- end,
      always_visible = false,
    }

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree", "oil" },
          winbar = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree", "oil" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = {
          -- require("auto-session.lib").current_session_name,
          branch,
          diff,
          -- "gfold",
          diagnostics,
        },
        lualine_c = {
          -- require("venv-selector").get_active_path(),
          -- require("venv-selector").get_active_venv(),
          -- require("venv-selector").retrieve_from_cache(),
          -- "swenv",
          -- "filename",
        },
        lualine_x = {},
        lualine_y = { progress, location },
        lualine_z = { spaces, encoding }, --, "fileformat"
      },
      inactive_sections = {
        lualine_a = { "filename", filetype },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
