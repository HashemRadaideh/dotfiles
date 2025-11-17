return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    show_end_of_buffer = false,
    styles = {
      comments = { "italic" },
      -- conditionals = { "italic" },
      -- loops = {},
      -- functions = {},
      -- keywords = {},
      -- strings = {},
      -- variables = {},
      -- numbers = {},
      -- booleans = {},
      -- properties = {},
      -- types = {},
      -- operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    default_integrations = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      -- For more plugins integrations (https://github.com/catppuccin/nvim#integrations)
    },
  },
  config = function(_, opts)
    vim.cmd.colorscheme("catppuccin-" .. opts.flavour)
  end,
}
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     vim.cmd.colorscheme([[tokyonight]])
--   end,
-- }
