return {
  "olimorris/persisted.nvim",
  lazy = false,
  opts = {
    autostart = true,
    follow_cwd = true,
    use_git_branch = true,
    autoload = true,
    should_save = function()
      if vim.bo.filetype == "Avante" then
        return false
      elseif vim.bo.filetype == "AvanteInput" then
        return false
      elseif vim.bo.filetype == "AvanteSelectedFiles" then
        return false
      elseif vim.bo.filetype == "codecompanion" then
        return false
      elseif vim.bo.filetype == "neo-tree" then
        return false
      elseif vim.bo.filetype == "alpha" then
        return false
      end
      return true
    end,
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    ignored_dirs = {
      { "~", exact = true },
      { "~/.config", exact = true },
      { "~/Workspace", exact = true },
      { "~/Projects", exact = true },
      "~/Downloads",
      { "/", exact = true },
      "/tmp",
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
      "<leader>ss",
      "<cmd>Telescope persisted<CR>",
      { noremap = true, silent = true, desc = "Select a session" },
    },
  },
}
