return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      ft_ignore = { "neo-tree", "Avante", "AvanteInput", "AvanteSelectedFiles" },
      segments = {
        {
          text = {
            -- function(args)
            --   return ((args.lnum % 2 > 0) and "%#DiffDelete#%=" or "%#DiffAdd#%=") .. "%l"
            -- end,
            "%l "
          },
          click = "v:lua.ScLa"
        },
        {
          sign = {
            name = {
              "DapBreakpoint",
              "DapBreakpointCondition",
              "DapBreakpointRejected",
              "DapStopped",
              "DapLogPoint"
            },
            maxwidth = 1,
            auto = false,
            wrap = false,
          },
          condition = { builtin.not_empty },
          click = "v:lua.ScSa",
        },
        {
          sign = {
            namespace = { "diagnostic" },
            name = { "Diagnostic", },
            maxwidth = 1,
            auto = false,
            wrap = false,
          },
          condition = { builtin.not_empty },
          click = "v:lua.ScSa",
        },
        {
          text = { "%C " },
          click = "v:lua.ScFa"
        },
        {
          sign = {
            namespace = { "gitsigns" },
            colwidth = 1,
            auto = false,
            wrap = false,
          },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
