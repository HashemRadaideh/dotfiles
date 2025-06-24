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
    current_line_blame_formatter = "        <author>: <abbrev_sha>",
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
