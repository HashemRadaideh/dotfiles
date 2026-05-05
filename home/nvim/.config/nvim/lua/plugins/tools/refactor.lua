return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>rr",
      function()
        require("refactoring").select_refactor({ prefer_ex_cmd = true })
      end,
      mode = { "n", "x" },
      desc = "Refactor: Select action",
    },
    {
      "<leader>re",
      function()
        return require("refactoring").refactor("Extract Function")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Extract function",
    },
    {
      "<leader>rf",
      function()
        return require("refactoring").refactor("Extract Function To File")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Extract function to file",
    },
    {
      "<leader>rv",
      function()
        return require("refactoring").refactor("Extract Variable")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Extract variable",
    },
    {
      "<leader>ri",
      function()
        return require("refactoring").refactor("Inline Function")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Inline function",
    },
    {
      "<leader>rI",
      function()
        return require("refactoring").refactor("Inline Variable")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Inline variable",
    },
    {
      "<leader>rb",
      function()
        return require("refactoring").refactor("Extract Block")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Extract block",
    },
    {
      "<leader>rbf",
      function()
        return require("refactoring").refactor("Extract Block To File")
      end,
      mode = { "n", "x" },
      desc = "Refactor: Extract block to file",
    },
  },
  opts = {
    prompt_func_return_type = {
      go = true,
      java = true,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
    prompt_func_param_type = {
      go = true,
      java = true,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
    show_success_message = false,
  },
}