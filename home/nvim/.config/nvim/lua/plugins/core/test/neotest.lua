return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Go
    "nvim-neotest/neotest-go",

    -- Python
    "nvim-neotest/neotest-python",

    -- Rust
    "rouge8/neotest-rust",

    -- JavaScript / TypeScript
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",

    -- Lua
    "MisanthropicBit/neotest-busted",

    -- Ruby
    "olimorris/neotest-rspec",

    -- PHP
    "olimorris/neotest-phpunit",

    -- Dart / Flutter
    "sidlatau/neotest-dart",

    -- C# / F#
    "Issafalcon/neotest-dotnet",

    -- Haskell
    "mrcjkb/neotest-haskell",

    -- Java / Kotlin (JUnit)
    "rcasia/neotest-java",

    -- C / C++ (Google Test)
    "alfaix/neotest-gtest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-go"),
        require("neotest-python")({ runner = "pytest" }),
        require("neotest-rust"),
        require("neotest-jest")({ jestCommand = "npx jest" }),
        require("neotest-vitest"),
        require("neotest-busted"),
        require("neotest-rspec"),
        require("neotest-phpunit"),
        require("neotest-dart"),
        require("neotest-dotnet"),
        require("neotest-haskell"),
        require("neotest-java"),
        require("neotest-gtest"),
      },
    })
  end,
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run file",
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run suite",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Output panel",
    },
    {
      "<leader>tS",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Summary",
    },
  },
}