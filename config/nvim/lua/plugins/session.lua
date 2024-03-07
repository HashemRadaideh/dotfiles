-- local status_ok, Path = pcall(require, "plenary.path")
-- local ok, sessions = pcall(require, "session_manager")

-- if not ok and not status_ok then
--   return
-- end

-- sessions.setup({
--   sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
--   path_replacer = "__",                                        -- The character to which the path separator will be replaced for session files.
--   colon_replacer = "++",                                       -- The character to which the colon symbol will be replaced for session files.
--   -- autoload_mode = require("session_manager.config").AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
--   autoload_mode = "Disabled",                                  -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
--   autosave_last_session = true,                                -- Automatically save last session on exit and on session switch.
--   autosave_ignore_not_normal = true,                           -- Plugin will not save a session when no buffers are opened, or all of them aren"t writable or listed.
--   autosave_ignore_dirs = {},                                   -- A list of directories where the session will not be autosaved.
--   autosave_ignore_filetypes = {                                -- All buffers of these file types will be closed before the session is saved.
--     "gitcommit",
--   },
--   autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
--   autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
--   max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don"t want to shorten the path at all.
-- })

-- -- vim.ui.select("load_session")
-- -- vim.ui.select("delete_session")

local ok, sessions = pcall(require, "auto-session")

if not ok then
  return
end

sessions.setup {
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
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
