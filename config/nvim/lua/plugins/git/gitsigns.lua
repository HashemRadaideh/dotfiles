return {
  "lewis6991/gitsigns.nvim",
  -- tag = 'release',
  opts = {
    signs = {
      add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = {
        hl = "GitSignsChange",
        text = "│",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = {
        hl = "GitSignsDelete",
        text = "‾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "~",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    sign_priority = 6,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "right_align", -- "eol" | "overlay" | "right_align"
      delay = 100,
      ignore_whitespace = true,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    -- current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

    yadm = {
      enable = false,
    },
    attach_to_untracked = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map({ "n", "v" }, "<leader>gsh", ":Gitsigns stage_hunk<CR>")
      map({ "n", "v" }, "<leader>grh", ":Gitsigns reset_hunk<CR>")
      map("n", "<leader>gSh", gs.stage_buffer)
      map("n", "<leader>guh", gs.undo_stage_hunk)
      map("n", "<leader>gRh", gs.reset_buffer)
      map("n", "<leader>gph", gs.preview_hunk)
      map("n", "<leader>gbh", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>gtb", gs.toggle_current_line_blame)
      map("n", "<leader>gdh", gs.diffthis)
      map("n", "<leader>gDh", function()
        gs.diffthis("~")
      end)
      map("n", "<leader>gtd", gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "gih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
}