return {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "ChatGPT",
  },
  keys = {
    { "<leader>ch", desc = "toggle chatgpt" },
  },
  opts = {
    api_key_cmd = "gpg --decrypt ~/secret.txt.gpg 2>/dev/null",
  },
}
