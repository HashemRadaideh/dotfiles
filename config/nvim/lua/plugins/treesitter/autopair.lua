return {
  "windwp/nvim-autopairs",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disabled_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
      map = "<C-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
    enable_check_bracket_line = true,
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  },
}
