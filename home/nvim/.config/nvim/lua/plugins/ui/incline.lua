return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      padding = 0,
      margin = { horizontal = 0 },
      placement = { horizontal = "right", vertical = "top" },
      overlap = {
        borders = true,
        statusline = true,
        tabline = true,
        winbar = true,
      },
      winhighlight = {
        active = {
          EndOfBuffer = "None",
          Normal = "InclineNormal",
          Search = "none",
        },
        inactive = {
          EndOfBuffer = "None",
          Normal = "InclineNormalNC",
          Search = "none",
        },
      },
    },
    highlight = {
      groups = {
        InclineNormal = {
          default = true,
          group = "none",
        },
        InclineNormalNC = {
          default = true,
          group = "none",
        },
      },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[Untitled]"
      end

      local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

      local function get_git_diff()
        local icons = { removed = " ", modified = " ", changed = " ", added = " " }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { "▏" })
        end
        return labels
      end

      local function get_diagnostic_label()
        local icons = { error = " ", warn = " ", info = " ", hint = "󰌶 " }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { "▏" })
        end
        return label
      end

      return {
        {
          get_diagnostic_label(),
          guibg = "none",
          ctermbg = "none",
        },
        {
          get_git_diff(),
          guibg = "none",
          ctermbg = "none",
        },
        {
          filename,
          " ",
          gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
          guibg = "none",
          ctermbg = "none",
        },
        {
          not ft_icon and "" or {
            " ",
            ft_icon,
            " ",
            guibg = ft_color,
            guifg = require("incline.helpers").contrast_color(ft_color),
            blend = 0,
          },
        },
      }
    end,
  },
}