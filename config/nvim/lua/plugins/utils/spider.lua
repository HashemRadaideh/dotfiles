return {
  -- {
  --   "bkad/CamelCaseMotion",
  --   keys = {
  --     { "w", "<Plug>CamelCaseMotion_w", { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "b", "<Plug>CamelCaseMotion_b", { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "e", "<Plug>CamelCaseMotion_e", { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "ge", "<Plug>CamelCaseMotion_ge", { noremap = true, silent = true }, mode = { "n", "v" } },

  --     { "iw", "<Plug>CamelCaseMotion_iw", { noremap = true, silent = true }, mode = { "o", "x" } },
  --     { "ib", "<Plug>CamelCaseMotion_ib", { noremap = true, silent = true }, mode = { "o", "x" } },
  --     { "ie", "<Plug>CamelCaseMotion_ie", { noremap = true, silent = true }, mode = { "o", "x" } },

  --     {
  --       "<C-Left>",
  --       "<C-o><Plug>CamelCaseMotion_b",
  --       { noremap = true, silent = true },
  --       mode = "i",
  --     },
  --     {
  --       "<C-Right>",
  --       "<C-o><Plug>CamelCaseMotion_w",
  --       { noremap = true, silent = true },
  --       mode = "i",
  --     },
  --   },
  -- },

  {
    "chrisgrieser/nvim-spider",
    -- dependencies = {
    --   "theHamsta/nvim_rocks",
    --   build = "pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
    --   config = function()
    --     require("nvim_rocks").ensure_installed("luautf8")
    --   end,
    -- },
    lazy = true,
    opts = {
      skipInsignificantPunctuation = true,
      subwordMovement = true,
    },
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
      -- {
      --   "<C-f>",
      --   "<Esc><cmd>lua require('spider').motion('w')<CR>i",
      --   mode = { "i" },
      -- },
      -- {
      --   "<C-b>",
      --   "<Esc><cmd>lua require('spider').motion('b')<CR>i",
      --   mode = { "i" },
      -- },
    },
  },
}
