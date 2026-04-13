return {
  "NickvanDyke/opencode.nvim",
  cmd = { "OpencodePrompt" },
  config = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true
  end,
  keys = {
    {
      "<leader>oA",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      { desc = "Ask opencode" },
    },
    {
      "<leader>ox",
      function()
        require("opencode").select()
      end,
      { desc = "Execute opencode action…" },
    },
    {
      "<leader>oa",
      function()
        require("opencode").prompt("@this")
      end,
      { desc = "Add to opencode" },
    },
    {
      "<leader>ot",
      function()
        require("opencode").toggle()
      end,
      { desc = "Toggle opencode" },
    },
    {
      "<leader>ou",
      function()
        require("opencode").command("session.half.page.up")
      end,
      { desc = "opencode half page up" },
    },
    {
      "<leader>od",
      function()
        require("opencode").command("session.half.page.down")
      end,
      { desc = "opencode half page down" },
    },
  },
}
