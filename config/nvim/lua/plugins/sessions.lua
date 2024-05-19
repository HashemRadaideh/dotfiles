return {
  "rmagatti/auto-session",
  event = { "VimEnter" },
  keys = {
    {
      -- session manager mappings
      -- vim.keymap.set('n', '<leader>ss', '<cmd>lua require"session_manager".load_session()<cr>, { noremap = true, silent = true, }')
      -- vim.keymap.set('n', '<leader>sd', '<cmd>lua require"session_manager".delete_session()<cr>', { noremap = true, silent = true, })

      "<leader>ss",
      "<cmd>lua require('auto-session.session-lens').search_session()<CR>",
      { noremap = true, silent = true, desc = "Select a session" },
    },
    {
      "<leader>sd",
      "<cmd>Autosession delete<CR>",
      { noremap = true, silent = true, desc = "Detele a session" },
    },
  },
  opts = {
    log_level = vim.log.levels.ERROR,
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    auto_session_use_git_branch = false,

    auto_session_enable_last_session = false,

    -- ⚠️ This will only work if Telescope.nvim is installed
    -- The following are already the default values, no need to provide them if these are already the settings you want.
    session_lens = {
      -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
      buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },
  },
}
