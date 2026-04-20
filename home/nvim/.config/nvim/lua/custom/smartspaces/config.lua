local M = {}

M.defaults = {
  min_alignment_count = 3,
  gap_tolerance_mult  = 3,
  min_gap_tolerance   = 2,
  min_spaces          = 2,
  space_char          = "⋅",
  ft_ignore           = { "gitcommit", "" },
  hl                  = {
    alignment = "SmartSpacesAlignment",
    overflow  = "SmartSpacesOverflow",
    normal    = "Whitespace",
  },
  overflow            = {
    enabled = true,
    hl_opts = { sp = "#e06c75", underline = true },
  },
  alignment_hl_opts   = { link = "IblIndent", default = true },
}

M.options = {}

function M.set(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
