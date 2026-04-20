return {
  "Weissle/persistent-breakpoints.nvim",
  event = "UIEnter",
  keys = {
    {
      "<Leader>db",
      function()
        require("persistent-breakpoints.api").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<Leader>dB",
      function()
        require("persistent-breakpoints.api").set_conditional_breakpoint()
      end,
      desc = "Conditional breakpoint",
    },
    {
      "<Leader>lp",
      function()
        require("persistent-breakpoints.api").set_log_point()
      end,
    },
    {
      "<leader>dc",
      function()
        require("persistent-breakpoints.api").clear_all_breakpoints()
      end,
    },
  },
  config = function()
    require("persistent-breakpoints").setup({
      load_breakpoints_event = { "BufReadPost" },
    })
  end,
}
