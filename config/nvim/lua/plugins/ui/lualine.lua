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
      cond = hide_in_width,
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
      cond = hide_in_width,
      always_visible = false,
    }

    local location = {
      "location",
      cond = hide_in_width,
      always_visible = false,
    }

    local progress = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local line_ratio = current_line / total_lines
      local chars = { "█", "▇", "▆", "▅", "▄", "▃", "▂", "▁", "▁", " " } -- "_",
      local index = math.ceil(line_ratio * #chars)
      return math.floor(line_ratio * 100) .. "%% │ " .. chars[index]
    end

    local spaces = function()
      return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    local encoding = {
      "encoding",
      -- fmt = function(str)
      --   return "encoding: " .. str
      -- end,
      cond = hide_in_width,
      always_visible = false,
    }

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "│",
        section_separators = "",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree" }, -- , "AvanteInput", "Avante"
          winbar = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree" },
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
        },
        lualine_c = {
          -- require("venv-selector").get_active_path(),
          -- require("venv-selector").get_active_venv(),
          -- require("venv-selector").retrieve_from_cache(),
          -- "swenv",
          "filename",
          diagnostics,
        },
        lualine_x = { filetype },
        lualine_y = { { progress, cond = hide_in_width }, location },
        lualine_z = { "fileformat" }, --  { spaces, cond = hide_in_width }, encoding,
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { filetype },
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
