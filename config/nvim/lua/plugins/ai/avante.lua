return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  -- build = "make BUILD_FROM_SOURCE=true",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons", -- echasnovski/mini.icons
    "zbirenbaum/copilot.lua",
    "MeanderingProgrammer/render-markdown.nvim",
    -- {
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
  },
  opts = {
    provider = "gemini",
    auto_suggestions_provider = "gemini",
    cursor_applying_provider = "gemini",
    gemini = {
      model = "gemini-2.0-flash",
    },
    copilot = {
      model = "claude-3.5-sonnet",
    },
    ollama = {
      model = "qwen2.5-coder:3b",
    },
    claude = {
      model = "claude-3-7-sonnet-20250219",
    },
    openai = {
      model = "gpt-4o",
    },
    -- azure = {},
    -- bedrock = {},
    -- vertex = {},
    -- vertex_cluade = {},
    cohere = {
      model = "command-a-03-2025",
    },
    aihubmix = {
      model = "gpt-4o-2024-11-20",
    },
    vendors = {
      together = {
        __inherited_from = "openai",
        api_key_name = "TOGETHER_API_KEY",
        endpoint = "https://api.together.xyz/v1/chat/completions",
        model = "meta-llama/Meta-Llama-3.1-8B-Instruct-Turbo",
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
      qianwen = {
        __inherited_from = "openai",
        api_key_name = "DASHSCOPE_API_KEY",
        endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
        model = "qwen-coder-plus-latest",
      },
      mistral = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        model = "mistral-large-latest",
      },
      perplexity = {
        __inherited_from = "openai",
        api_key_name = "cmd:bw get notes perplexity-api-key",
        endpoint = "https://api.perplexity.ai",
        model = "llama-3.1-sonar-large-128k-online",
      },
      openrouter = {
        __inherited_from = "openai",
        api_key_name = "OPENROUTER_API_KEY",
        endpoint = "https://openrouter.ai/api/v1",
        model = "deepseek/deepseek-r1",
      },
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
      },
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, searchapi, google or kagi
    },
    behaviour = {
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      enable_token_counting = true, -- Whether to enable token counting. Default to true.
      auto_suggestions = false,
      enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
      enable_claude_text_editor_tool_mode = false,
    },
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
    windows = {
      position = "right",
      width = 40,
      wrap = true,
      sidebar_header = {
        align = "center",
        rounded = true,
      },
    },
    mappings = {
      suggestion = {
        accept = "<tab>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "avante: refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "avante: edit",
      mode = "v",
    },
    {
      "<leader>at",
      function()
        require("avante.api").toggle()
      end,
      desc = "avante: toggle",
      mode = { "n", "v" },
    },
  },
}
