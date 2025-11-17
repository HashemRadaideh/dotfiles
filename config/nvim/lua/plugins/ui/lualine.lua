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

    local mcphub = {
      function()
        -- Check if MCPHub is loaded
        if not vim.g.loaded_mcphub then
          return "󰐻 -"
        end

        local count = vim.g.mcphub_servers_count or 0
        local status = vim.g.mcphub_status or "stopped"
        local executing = vim.g.mcphub_executing

        -- Show "-" when stopped
        if status == "stopped" then
          return "󰐻 -"
        end

        -- Show spinner when executing, starting, or restarting
        if executing or status == "starting" or status == "restarting" then
          local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          local frame = math.floor(vim.loop.now() / 100) % #frames + 1
          return "󰐻 " .. frames[frame]
        end

        return "󰐻 " .. count
      end,
      color = function()
        if not vim.g.loaded_mcphub then
          return { fg = "#6c7086" } -- Gray for not loaded
        end

        local status = vim.g.mcphub_status or "stopped"
        if status == "ready" or status == "restarted" then
          return { fg = "#50fa7b" } -- Green for connected
        elseif status == "starting" or status == "restarting" then
          return { fg = "#ffb86c" } -- Orange for connecting
        else
          return { fg = "#ff5555" } -- Red for error/stopped
        end
      end,
      cond = function()
        local buf_ft = vim.bo.filetype

        return string.match(string.lower(buf_ft), "avante") ~= nil
      end,
    }

    local hide_buffertypes = function()
      local buf_ft = vim.bo.filetype

      return string.match(string.lower(buf_ft), "avante") == nil
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      -- sections = { "hint", "warn", "error" },
      -- symbols = { error = " ", warn = " " },
      colored = true,
      update_in_insert = true,
      -- cond = hide_in_width,
      always_visible = false,
    }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
      always_visible = false,
    }

    local filename = {
      "filename",
      path = 0,
      symbols = {
        modified = "●",
        readonly = "",
        unnamed = "[Untitled]",
      },
      cond = hide_buffertypes,
    }

    local project_name = function()
      local cwd = vim.fn.getcwd()
      return vim.fn.fnamemodify(cwd, ":t") -- Extract the last part of the current working directory
    end

    local project = {
      project_name,
      icon = "",
      cond = hide_in_width,
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
      cond = hide_buffertypes,
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
          project,
          branch,
          diff,
          -- "gfold",
        },
        lualine_c = {
          -- require("venv-selector").get_active_path(),
          -- require("venv-selector").get_active_venv(),
          -- require("venv-selector").retrieve_from_cache(),
          -- "swenv",
          filename,
        },
        lualine_x = {
          diagnostics,
          mcphub,
          filetype,
        },
        lualine_y = { { progress, cond = hide_in_width }, location },
        lualine_z = { "fileformat" }, --  { spaces, cond = hide_in_width }, encoding,
      },
      inactive_sections = {
        lualine_a = { filename },
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
