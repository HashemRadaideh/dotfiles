return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  opts = {
    transparent_background = true,
    flavour = "frappe",
    integrations = {
      blink_cmp = true,
      dap = true,
      dap_ui = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      lsp = true,
      mason = true,
      native_lsp = {
        enabled = true,
      },
      noice = true,
      notify = true,
      oil = true,
      semantic_tokens = true,
      snacks = true,
      treesitter = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-frappe")
  end,
}
