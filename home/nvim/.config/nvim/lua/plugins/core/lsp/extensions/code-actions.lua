return {
  "rachartier/tiny-code-action.nvim",
  event = "LspAttach",
  opts = {},
  keys = {
    {
      "<leader>ca",
      function()
        require("tiny-code-action").code_action()
      end,
      desc = "Code Action",
      mode = { "n", "x" },
    },
  },
}