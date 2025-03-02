return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make", -- build = "make BUILD_FROM_SOURCE=true",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",
    "MeanderingProgrammer/render-markdown.nvim",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
  },
  opts = {
    provider = "claude",
    auto_suggestions_provider = "claude",
    claude = {
      model = "claude-3-5-sonnet-20241022",
      -- api_key_name = { "bw", "get", "notes", "anthropic-api-key", "--session", "$BW_SESSION" },
      -- api_key_name = "cmd:bw get notes anthropic-api-key --session $BW_SESSION",
    },
    vendors = {
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "http://127.0.0.1:11434/v1",
        model = "llama3.2:3b",
      },
      together = {
        __inherited_from = "openai",
        api_key_name = "TOGETHER_API_KEY",
        endpoint = "https://api.together.xyz/v1/chat/completions",
        model = "meta-llama/Llama-3.3-70B-Instruct-Turbo",
      },
      perplexity = {
        __inherited_from = "openai",
        api_key_name = "cmd:bw get notes perplexity-api-key",
        endpoint = "https://api.perplexity.ai",
        model = "llama-3.1-sonar-large-128k-online",
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
    },
    windows = {
      position = "right",
      width = 50,
    },
  },
}
