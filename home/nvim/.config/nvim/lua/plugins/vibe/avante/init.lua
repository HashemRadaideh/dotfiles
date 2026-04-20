return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = vim.fn.has("win32") == 0 and "make" -- "make BUILD_FROM_SOURCE=true",
    or "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons", -- echasnovski/mini.icons
    "zbirenbaum/copilot.lua",
    "MeanderingProgrammer/render-markdown.nvim",
    "folke/snacks.nvim",
  },
  cmd = {
    "AvanteToggle",
    "AvanteChatNew",
    "AvanteHistory",
    "AvanteModels",
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "Avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "Avante: refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "Avante: edit selection",
      mode = "v",
    },
    {
      "<leader>at",
      function()
        require("avante.api").toggle()
      end,
      desc = "Avante: toggle",
      mode = { "n", "v" },
    },
    {
      "<leader>an",
      function()
        require("avante.api").ask({ new_chat = true })
      end,
      desc = "Avante: new chat",
    },
    {
      "<leader>ah",
      function()
        require("avante.api").select_history()
      end,
      desc = "Avante: chat history",
    },
    {
      "<leader>am",
      function()
        require("avante.api").select_model()
      end,
      desc = "Avante: pick model",
    },
    {
      "<leader>az",
      function()
        vim.defer_fn(function()
          require("avante.api").zen_mode()
        end, 100)
      end,
      desc = "Avante: zen mode",
    },
  },
  opts = require("plugins.vibe.avante.config"),
}
