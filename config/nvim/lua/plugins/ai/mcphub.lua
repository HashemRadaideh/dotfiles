return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "MCPHub",
  build = "npm install -g mcp-hub@latest",
  opts = {
    extensions = {
      avante = {},
    },
  },
  keys = {
    {
      "<leader>mc",
      "<cmd>MCPHub<CR>",
      { noremap = true, silent = true },
    },
  },
}
