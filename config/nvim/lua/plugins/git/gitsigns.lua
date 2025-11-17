return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  -- tag = 'release',
  keys = {
    {
      "<leader>gb",
      "<cmd>Gitsigns toggle_current_line_blame<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>wtf",
      "<cmd>Gitsigns blame_line full<CR>",
      { noremap = true, silent = true },
    },
  },
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┊" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┊" },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
      ignore_whitespace = true,
      virt_text_priority = 100,
      use_focus = true,
    },
    --     • `<abbrev_sha>`
    --     • `<orig_lnum>`
    --     • `<final_lnum>`
    --     • `<author>`
    --     • `<author_mail>`
    --     • `<author_time>` or `<author_time:FORMAT>`
    --     • `<author_tz>`
    --     • `<committer>`
    --     • `<committer_mail>`
    --     • `<committer_time>` or `<committer_time:FORMAT>`
    --     • `<committer_tz>`
    --     • `<summary>`
    --     • `<previous>`
    --     • `<filename>`

    --   For `<author_time:FORMAT>` and `<committer_time:FORMAT>`, `FORMAT` can
    --   be any valid date format that is accepted by `os.date()` with the
    --   addition of `%R` (defaults to `%Y-%m-%d`):

    --     • `%a`  abbreviated weekday name (e.g., Wed)
    --     • `%A`  full weekday name (e.g., Wednesday)
    --     • `%b`  abbreviated month name (e.g., Sep)
    --     • `%B`  full month name (e.g., September)
    --     • `%c`  date and time (e.g., 09/16/98 23:48:10)
    --     • `%d`  day of the month (16) [01-31]
    --     • `%H`  hour, using a 24-hour clock (23) [00-23]
    --     • `%I`  hour, using a 12-hour clock (11) [01-12]
    --     • `%M`  minute (48) [00-59]
    --     • `%m`  month (09) [01-12]
    --     • `%p`  either "am" or "pm" (pm)
    --     • `%S`  second (10) [00-61]
    --     • `%w`  weekday (3) [0-6 = Sunday-Saturday]
    --     • `%x`  date (e.g., 09/16/98)
    --     • `%X`  time (e.g., 23:48:10)
    --     • `%Y`  full year (1998)
    --     • `%y`  two-digit year (98) [00-99]
    --     • `%%`  the character `%`
    --     • `%R`  relative (e.g., 4 months ago)
    current_line_blame_formatter = "    (<abbrev_sha>) <author> about <author_time:%R>: <summary>",
    sign_priority = 50,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = nil,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    -- on_attach = function(bufnr)
    --   local gs = package.loaded.gitsigns

    --   local function map(mode, l, r, opts)
    --     opts = opts or {}
    --     opts.buffer = bufnr
    --     vim.keymap.set(mode, l, r, opts)
    --   end

    --   -- Navigation
    --   map("n", "]c", function()
    --     if vim.wo.diff then
    --       return "]c"
    --     end
    --     vim.schedule(function()
    --       gs.next_hunk()
    --     end)
    --     return "<Ignore>"
    --   end, { expr = true })

    --   map("n", "[c", function()
    --     if vim.wo.diff then
    --       return "[c"
    --     end
    --     vim.schedule(function()
    --       gs.prev_hunk()
    --     end)
    --     return "<Ignore>"
    --   end, { expr = true })

    --   -- Actions
    --   map({ "n", "v" }, "<leader>gsh", ":Gitsigns stage_hunk<CR>")
    --   map({ "n", "v" }, "<leader>grh", ":Gitsigns reset_hunk<CR>")
    --   map("n", "<leader>gSh", gs.stage_buffer)
    --   map("n", "<leader>guh", gs.undo_stage_hunk)
    --   map("n", "<leader>gRh", gs.reset_buffer)
    --   map("n", "<leader>gph", gs.preview_hunk)
    --   map("n", "<leader>wtf", function()
    --     gs.blame_line({ full = true })
    --   end)
    --   map("n", "<leader>gb", gs.toggle_current_line_blame)
    --   map("n", "<leader>gdt", gs.diffthis)
    --   -- map("n", "<leader>gDh", function()
    --   --   gs.diffthis("~")
    --   -- end)
    --   map("n", "<leader>gtd", gs.toggle_deleted)

    --   -- Text object
    --   map({ "o", "x" }, "<leader>gst", ":<C-u>Gitsigns select_hunk<CR>")
    -- end,
  },
}
