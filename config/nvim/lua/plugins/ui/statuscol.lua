return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      ft_ignore = { "neo-tree", "Avante", "AvanteInput", "AvanteSelectedFiles" },
      segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        {
          sign = {
            namespace = { "gitsigns" },
            colwidth = 1,
            auto = true,
            wrap = true,
          },
          click = "v:lua.ScSa",
        },
        {
          sign = {
            name = { ".*" },
            text = { ".*" },
            namespace = { ".*" },
            maxwidth = 1,
            auto = false,
            wrap = true,
          },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
