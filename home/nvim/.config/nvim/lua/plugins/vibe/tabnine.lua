return {
  "codota/tabnine-nvim",
  build = function()
    if vim.loop.os_uname().sysname == "Windows_NT" then
      return "pwsh.exe -file .\\dl_binaries.ps1"
    else
      return "./dl_binaries.sh"
    end
  end,
  -- event = "BufReadPost",
  -- cmd = {
  --   "TabnineStatus",
  --   "TabnineDisable",
  --   "TabnineEnable",
  --   "TabnineToggle",
  -- },
  -- keys = {
  --   { "<leader>tn", desc = "toggle tabnine" },
  -- },
  config = function()
    require("tabnine").setup({
      disable_auto_comment = true,
      accept_keymap = "<Tab>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt" },
      log_file_path = nil, -- absolute path to Tabnine log file
    })
  end,
}
