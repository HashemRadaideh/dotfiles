return {
  -- "rmagatti/auto-session",
  -- -- event = { "VimEnter" },
  -- lazy = false,
  -- -- opts = {
  -- --   log_level = vim.log.levels.ERROR,
  -- --   auto_session_suppress_dirs = { "~/", "~/Workspace", "~/Projects", "~/Downloads", "/" },
  -- --   auto_session_use_git_branch = false,

  -- --   auto_session_enable_last_session = false,

  -- --   -- ⚠️ This will only work if Telescope.nvim is installed
  -- --   -- The following are already the default values, no need to provide them if these are already the settings you want.
  -- --   session_lens = {
  -- --     -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
  -- --     buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
  -- --     load_on_setup = true,
  -- --     theme_conf = { border = true },
  -- --     previewer = false,
  -- --   },
  -- -- },
  -- opts = {
  --   auto_restore_last_session = false,
  --   log_level = 4,
  --   session_lens = {
  --     buftypes_to_ignore = {},
  --     load_on_setup = true,
  --     previewer = false,
  --     theme_conf = { border = true },
  --   },
  --   suppressed_dirs = { "~/", "~/Workspace", "~/Projects", "~/Downloads", "/" },
  --   use_git_branch = false,
  -- },
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
  -- config = true,
  opts = {
    autostart = true,
    follow_cwd = true,
    use_git_branch = true,
    autoload = true,
    should_save = function()
      -- Do not save if the alpha dashboard is the current filetype
      if vim.bo.filetype == "alpha" then
        return false
      end
      return true
    end,
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    ignored_dirs = {
      { "~/", exact = true },
      { "~/Workspace", exact = true },
      { "~/Projects", exact = true },
      { "~/Downloads", exact = true },
      { "/", exact = true },
    },
    telescope = {
      mappings = {
        copy_session = "<C-c>",
        change_branch = "<C-b>",
        delete_session = "<C-d>",
      },
      icons = {
        selected = " ",
        dir = "  ",
        branch = " ",
      },
    },
  },
  keys = {
    {
      -- session manager mappings
      -- vim.keymap.set('n', '<leader>ss', '<cmd>lua require"session_manager".load_session()<cr>, { noremap = true, silent = true, }')
      -- vim.keymap.set('n', '<leader>sd', '<cmd>lua require"session_manager".delete_session()<cr>', { noremap = true, silent = true, })

      "<leader>ss",
      "<cmd>SessionSelect<CR>",
      { noremap = true, silent = true, desc = "Select a session" },
    },
    {
      "<leader>sd",
      "<cmd>SessionDelete<CR>",
      { noremap = true, silent = true, desc = "Detele a session" },
    },
  },
}
