return {
  -- {
  --   "codota/tabnine-nvim",
  --   build = function()
  --     if vim.loop.os_uname().sysname == "Windows_NT" then
  --       return "pwsh.exe -file .\\dl_binaries.ps1"
  --     else
  --       return "./dl_binaries.sh"
  --     end
  --   end,
  --   -- event = "BufReadPost",
  --   -- cmd = {
  --   --   "TabnineStatus",
  --   --   "TabnineDisable",
  --   --   "TabnineEnable",
  --   --   "TabnineToggle",
  --   -- },
  --   -- keys = {
  --   --   { "<leader>tn", desc = "toggle tabnine" },
  --   -- },
  --   config = function()
  --     require("tabnine").setup({
  --       disable_auto_comment = true,
  --       accept_keymap = "<Tab>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#808080", cterm = 244 },
  --       exclude_filetypes = { "TelescopePrompt" },
  --       log_file_path = nil, -- absolute path to Tabnine log file
  --     })
  --   end,
  -- },

  {
    "David-Kunz/gen.nvim",
    cmd = { "Gen" },
    keys = {
      {
        "<leader>]",
        ":Gen<CR>",
        { noremap = true, silent = true },
        mode = { "n", "v" },
      },
      {
        "<leader>as",
        ':lua require("gen").select_model()<CR>',
        { noremap = true, silent = true },
        mode = { "n", "v" },
      },
    },
    opts = {
      model = "mistral",
      host = "localhost",
      port = "11434",
      display_mode = "float",
      show_prompt = false,
      show_model = true,
      quit_map = "q",
      no_auto_close = false,
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      command = function(options)
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      debug = false,
    },
    config = function()
      require("gen").prompts["Elaborate_Text"] = {
        prompt = "Elaborate the following text:\n$text",
        replace = true,
      }

      require("gen").prompts["Fix_Code"] = {
        prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      }
    end,
  },

  -- {
  --   "Exafunction/codeium.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   event = "BufReadPost",
  --   cmd = { "Codeium" },
  --   opts = {},
  -- },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  --   cmd = {
  --     "ChatGPT",
  --   },
  --   keys = {
  --     { "<leader>ch", desc = "toggle chatgpt" },
  --   },
  --   opts = {
  --       api_key_cmd = "gpg --decrypt ~/secret.txt.gpg 2>/dev/null"
  --   }
  --   end,
  -- },

  -- {
  --   "Bryley/neoai.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   cmd = {
  --     "NeoAI",
  --     "NeoAIOpen",
  --     "NeoAIClose",
  --     "NeoAIToggle",
  --     "NeoAIContext",
  --     "NeoAIContextOpen",
  --     "NeoAIContextClose",
  --     "NeoAIInject",
  --     "NeoAIInjectCode",
  --     "NeoAIInjectContext",
  --     "NeoAIInjectContextCode",
  --   },
  --   keys = {
  --     { "<leader>as", desc = "summarize text" },
  --     { "<leader>ag", desc = "generate git message" },
  --     { "<leader>ai", desc = "toggle ai" },
  --   },
  --   opts = {}
  -- },

  -- {
  --   'github/copilot.vim',
  --   cmd = "Copilot",
  --   keys = { { "<leader>co", desc = "toggle copilot" } }
  -- },
}
