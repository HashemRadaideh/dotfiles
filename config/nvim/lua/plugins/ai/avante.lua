return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make", -- "make BUILD_FROM_SOURCE=true",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons", -- echasnovski/mini.icons
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
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    cursor_applying_provider = "copilot",
    providers = {
      claude = {
        model = "claude-sonnet-4-20250514",
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      copilot = {
        model = "claude-4-5-sonnet",
      },
      gemini = {
        model = "gemini-2.5-pro",
      },
      openai = {
        model = "gpt-4o",
      },
      ollama = {
        model = "qwen2.5-coder:3b",
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
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
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
    acp_providers = {
      ["gemini-cli"] = {
        command = "gemini",
        args = { "--experimental-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
        },
      },
      ["claude-code"] = {
        command = "npx",
        args = { "@zed-industries/claude-code-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
      ["goose"] = {
        command = "goose",
        args = { "acp" },
      },
      ["codex"] = {
        command = "codex-acp",
        env = {
          NODE_NO_WARNINGS = "1",
          OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
        },
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
      return hub and hub:get_active_servers_prompt() or ""
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
      "<leader>av",
      function()
        require("avante.api").toggle()
      end,
      desc = "avante: toggle",
      mode = { "n", "v" },
    },
  },
}
