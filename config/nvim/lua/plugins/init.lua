return {
  -- {
  --   "mg979/vim-visual-multi",
  --   keys = {
  --     { "<C-g>",  "<Plug>multi_cursor_start_word_key",      { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "<C-G>",  "<Plug>multi_cursor_select_all_word_key", { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "g<C-g>", "<Plug>multi_cursor_start_key",           { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "g<C-G>", "<Plug>multi_cursor_select_all_key",      { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "<C-g>",  "<Plug>multi_cursor_next_key",            { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "<C-p>",  "<Plug>multi_cursor_prev_key",            { noremap = true, silent = true }, mode = { "n", "v" } },
  --     { "g<C-x>", "<Plug>multi_cursor_skip_key",            { noremap = true, silent = true }, mode = { "n", "v" } },
  --   },
  -- },

  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {
      enable_split_paste = true,
      custom_key_maps = {
        -- j and k: use gj/gk when count is 0
        {
          { "n", "x" },
          { "j", "<Down>" },
          function(_, count)
            if count == 0 then
              vim.cmd("normal! gj")
            else
              vim.cmd("normal! " .. count .. "j")
            end
          end,
        },

        {
          { "n", "x" },
          { "k", "<Up>" },
          function(_, count)
            if count == 0 then
              vim.cmd("normal! gk")
            else
              vim.cmd("normal! " .. count .. "k")
            end
          end,
        },

        -- w
        {
          { "n", "x" },
          "w",
          function(_, count)
            if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
              vim.cmd("normal! " .. count)
            end
            require("spider").motion("w")
          end,
        },

        -- e
        {
          { "n", "x" },
          "e",
          function(_, count)
            if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
              vim.cmd("normal! " .. count)
            end
            require("spider").motion("e")
          end,
        },

        -- b
        {
          { "n", "x" },
          "b",
          function(_, count)
            if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
              vim.cmd("normal! " .. count)
            end
            require("spider").motion("b")
          end,
        },

        {
          "n",
          "<Leader>sa",
          function(_, count, motion_cmd, char)
            vim.cmd("normal " .. count .. "sa" .. motion_cmd .. char)
          end,
          "mc",
        },
      },
      pre_hook = function()
        vim.opt.cursorline = false
        vim.cmd("NoMatchParen")
      end,
      post_hook = function()
        vim.opt.cursorline = true
        vim.cmd("DoMatchParen")
      end,
    },
    keys = {
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i" } },
      { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>" },
      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
      { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>" },
      { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
      { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },
      { "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = { "n", "x" } },
      { "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
      { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>" },
      { "<Leader>l", "<Cmd>MultipleCursorsLockToggle<CR>", mode = { "n", "x" } },
    },
  },

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
      customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
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
      {
        "cw",
        "c<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n" },
      },
      {
        "<C-f>",
        "<Esc>l<cmd>lua require('spider').motion('w')<CR>i",
        mode = { "i" },
      },
      {
        "<C-b>",
        "<Esc><cmd>lua require('spider').motion('b')<CR>i",
        mode = { "i" },
      },
    },
  },

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
    "tpope/vim-fugitive",
    cmd = "G",
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
}
